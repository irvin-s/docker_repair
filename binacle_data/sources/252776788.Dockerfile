FROM busybox:latest  
MAINTAINER Christophe Burki, christophe.burki@gmail.com  
  
COPY bin/waitsig /usr/local/bin/  
RUN chmod a+x /usr/local/bin/waitsig  
  
RUN mkdir -p /data  
VOLUME ["/data"]  
  
CMD ["/usr/local/bin/waitsig"]  

