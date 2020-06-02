FROM alpine:latest  
MAINTAINER Hellyna NG <hellyna@hellyna.com>  
  
ADD build /root/build  
RUN /root/build  

