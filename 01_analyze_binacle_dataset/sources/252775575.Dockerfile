FROM blalor/supervised:latest  
MAINTAINER Brian Lalor <blalor@bravo5.org>  
  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

