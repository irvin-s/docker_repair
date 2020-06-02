#  
# Dockerfile for aria2  
#  
FROM bash  
MAINTAINER kev <dongpingmax@163.com>  
  
# ENV TOKEN 00000000-0000-0000-0000-000000000000  
RUN set -xe \  
&& apk add -U aria2 \  
&& rm -rf /var/cache/apk/*  
  
VOLUME /home/aria2 /etc/aria2  
  
EXPOSE 6800  
CMD set -xe \  
&& aria2c --conf-path=/etc/aria2/aria2.conf  
  

