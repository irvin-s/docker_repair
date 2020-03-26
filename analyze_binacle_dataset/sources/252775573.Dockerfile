FROM blalor/supervised:latest  
MAINTAINER Brian Lalor <blalor@bravo5.org>  
  
EXPOSE 80  
## required env:  
## CANARYD_BASE_URL  
## CHECKS_URL  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

