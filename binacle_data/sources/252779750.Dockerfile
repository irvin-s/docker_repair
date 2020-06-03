# Dockerfile  
FROM nimmis/apache-php5  
  
MAINTAINER PRC Applications <patrick@prcapps.com>  
  
ADD . /var/www/php  
  
#RUN composer update -d /var/www/php  
#RUN chmod a+rwx -R /var/www/php/cache  
#RUN chmod a+rwx -R /var/www/php/output  
COPY apache.conf /etc/apache2/sites-available/000-default.conf  
  
EXPOSE 80  
EXPOSE 443  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

