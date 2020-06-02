FROM alpine:latest  
  
MAINTAINER Zeno Jiricek <airtonix@gmail.com>  
  
RUN apk update && \  
apk add \  
bash \  
jq \  
tree \  
samba-client  
  
RUN mkdir /mnt/{in, out}  
VOLUME /mnt/in  
VOLUME /mnt/out  
COPY ./resource/ /opt/resource/  
RUN chmod -R +x /opt/resource/*  

