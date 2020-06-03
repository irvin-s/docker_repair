FROM alpine:3.3  
MAINTAINER Ahmet Demir <ahmet2mir+github@gmail.com>  
  
RUN apk add --update python python-dev openssl ca-certificates curl py-pip  
ADD . /apps  
RUN cd /apps && pip install -r requirements.txt && python setup.py install  
RUN rm -rf /var/cache/apk/*  
RUN mkdir /data  
VOLUME /data  
WORKDIR /data  
ENTRYPOINT ["us3","-d","/data"]  

