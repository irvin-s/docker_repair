FROM busybox:latest  
  
ADD config/* /data/  
VOLUME /etc/logstash/conf.d  
CMD ["/bin/sh", "-c", "/bin/cp -fr /data/* /etc/logstash/conf.d/"]  

