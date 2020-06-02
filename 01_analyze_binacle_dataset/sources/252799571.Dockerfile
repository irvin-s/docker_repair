FROM dickeyxxx/base  
  
MAINTAINER Jeff Dickey jeff@dickeyxxx.com  
  
RUN apt-get install -y apache2  
  
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  
EXPOSE 80  

