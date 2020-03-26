FROM eboraas/apache  
  
COPY wait-tomcat.sh .  
  
COPY sources/dist /var/www/html/  
  
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf  
  
RUN apt-get update && apt-get -y install netcat  
  
RUN /usr/sbin/a2enmod rewrite  
RUN /usr/sbin/a2enmod proxy  
RUN /usr/sbin/a2enmod proxy_ajp  
RUN /usr/sbin/a2enmod proxy_http  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

