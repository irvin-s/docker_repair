FROM debian:jessie  
  
MAINTAINER "Dylan Lindgren" <dylan.lindgren@gmail.com>  
  
RUN mkdir -p /data  
VOLUME ["/data"]  
CMD ["true"]

