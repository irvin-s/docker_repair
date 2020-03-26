FROM alpine:latest  
MAINTAINER bluebu <bluebuwang@gmail.com>  
  
#------------------------------------------------------------------------------  
# Environment variables:  
#------------------------------------------------------------------------------  
RUN \  
apk --update --upgrade add \  
py-pip \  
&& rm /var/cache/apk/*  
  
RUN pip install shadowsocks  
  
ENV SERVER_ADDR=0.0.0.0 \  
SERVER_PORT=8899 \  
METHOD=aes-256-cfb \  
TIMEOUT=300 \  
WORKERS=10 \  
PASSWORD=  
  
#------------------------------------------------------------------------------  
# Populate root file system:  
#------------------------------------------------------------------------------  
ADD rootfs /  
  
#------------------------------------------------------------------------------  
# Expose ports and entrypoint:  
#------------------------------------------------------------------------------  
EXPOSE $SERVER_PORT  
  
ENTRYPOINT ["/entrypoint.sh"]  

