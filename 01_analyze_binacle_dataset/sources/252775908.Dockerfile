# Alpine base  
FROM alpine:latest  
MAINTAINER Olivier Blunt <contact@blunt.sh>  
  
# Install script  
COPY setup.sh /setup.sh  
RUN /bin/sh /setup.sh  
  
# Run  
EXPOSE 80  
CMD /bootstrap.sh

