FROM alpine:latest  
RUN apk update &&\  
apk add --no-cache py2-pip bash zip curl &&\  
pip --no-cache-dir install awscli --upgrade  

