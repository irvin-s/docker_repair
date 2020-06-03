FROM golang:1.8  
# Install glide  
RUN go get github.com/Masterminds/glide  
  
# Install tools  
RUN apt-get update \  
&& apt-get install -y \  
python-pip \  
python-virtualenv \  
&& apt-get clean  
  
ENV INODEBEAT_PATH "$GOPATH/src/github.com/codingame/inodebeat"  
COPY . $INODEBEAT_PATH  
  
WORKDIR $INODEBEAT_PATH  
  
# Install dependencies  
RUN glide install  
  
# Create inodebeat binary  
RUN make update && make  
  
RUN mkdir -p /etc/inodebeat/ \  
&& cp $INODEBEAT_PATH/inodebeat.yml /etc/inodebeat/inodebeat.yml \  
&& cp $INODEBEAT_PATH/inodebeat /usr/local/bin/inodebeat  
  
ENTRYPOINT [ "inodebeat" ]  
  
CMD [ "-c", "/etc/inodebeat/inodebeat.yml", "-e" ]  

