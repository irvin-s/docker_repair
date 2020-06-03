FROM blalor/supervised:latest  
MAINTAINER Brian Lalor <blalor@bravo5.org>  
  
EXPOSE 80  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

