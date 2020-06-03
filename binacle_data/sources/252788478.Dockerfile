FROM eboraas/apache-php:latest  
  
RUN apt-get update  
RUN apt-get install -y ca-certificates  
  
CMD /usr/sbin/apache2ctl -D FOREGROUND  

