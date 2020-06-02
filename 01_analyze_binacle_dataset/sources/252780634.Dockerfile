FROM alpine:latest  
  
RUN \  
apk update && \  
apk add git python py-pip && \  
pip install awsebcli  

