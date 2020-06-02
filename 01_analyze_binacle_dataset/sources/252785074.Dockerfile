FROM golang:1.8  
# Install tools  
RUN go get github.com/Masterminds/glide \  
&& apt-get update \  
&& apt-get install -y \  
python-pip \  
python-virtualenv \  
&& apt-get clean  
  
ENV ACTIVEMQBEAT_HOME "$GOPATH/src/github.com/codingame/activemqbeat"  
COPY . $ACTIVEMQBEAT_HOME  
  
WORKDIR $ACTIVEMQBEAT_HOME  
  
# Create activemqbeat binary  
# Create config directory  
# Clean up  
RUN make setup \  
&& make \  
&& mkdir -p /etc/activemqbeat/ \  
&& cp $ACTIVEMQBEAT_HOME/activemqbeat.yml /etc/activemqbeat/activemqbeat.yml \  
&& rm -rf build/ vendor/  
  
ENV PATH "$ACTIVEMQBEAT_HOME:$PATH"  
ENTRYPOINT [ "activemqbeat" ]  
  
CMD [ "-c", "/etc/activemqbeat/activemqbeat.yml", "-e" ]  

