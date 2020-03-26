FROM python:2.7-alpine  
MAINTAINER Assaf Berg <asssaf@localhost>  
  
ENV WORKDIR=/sttClient  
RUN mkdir -p $WORKDIR  
COPY requirements.txt $WORKDIR/  
  
RUN apk add --no-cache --virtual build-deps build-base \  
&& apk add --no-cache --virtual run-deps libffi-dev openssl-dev \  
&& cd $WORKDIR \  
&& pip install -r requirements.txt \  
&& apk del build-deps  
  
COPY sttClient.py $WORKDIR/  
  
WORKDIR $WORKDIR  
ENTRYPOINT [ "./sttClient.py" ]  
CMD [ "-h" ]  

