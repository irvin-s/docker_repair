FROM debian:jessie  
  
MAINTAINER "Braydee Johnson" <braydee@braydeejohnson.com>  
  
RUN mkdir -p /data  
VOLUME ["/data"]  
CMD ["true"]

