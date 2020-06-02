FROM alpine:latest  
RUN apk update &&\  
apk add \--no-cache py2-pip bash &&\  
pip --no-cache-dir install awscli --upgrade  

