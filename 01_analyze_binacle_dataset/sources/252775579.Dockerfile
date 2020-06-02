FROM blalor/java:latest  
MAINTAINER Brian Lalor <blalor@bravo5.org>  
  
## 5555 - Riemann TCP and UDP  
## 5556 - Riemann WS  
EXPOSE 5555 5555/udp 5556  
ADD src /tmp/src/  
RUN /tmp/src/config.sh  

