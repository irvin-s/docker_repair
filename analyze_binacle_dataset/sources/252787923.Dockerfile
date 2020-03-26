FROM php:5.6-apache  
  
MAINTAINER Josia <josia-login@rosskopfs.de>  
  
WORKDIR /root/  
  
ENV TZ "Europe/Berlin"  
ENV keydir /var/keys  
ENV wwwdir /var/www/html  
  
ADD ./apache-conf ./apache-conf  
RUN cat apache-conf | tee -a /etc/apache2/apache2.conf  
  
ADD init.sh /root/init.sh  
RUN chmod +x init.sh  
  
#RUN chown www-data:www-data -R $wwwdir  
#ADD htdocs/* /var/www/html/  
#ADD index.php /var/www/html/index.php  
CMD ["bash", "init.sh"]  

