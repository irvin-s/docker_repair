FROM blalor/supervised:latest  
MAINTAINER Brian Lalor <blalor@bravo5.org>  
  
EXPOSE 80 5000/udp  
  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

