FROM alledia/lamp  
  
MAINTAINER Alledia <suport@alledia.com>  
  
# Configure PHP  
COPY php/20-custom.ini /etc/php5/apache2/conf.d/20-custom.ini  
COPY php/20-custom.ini /etc/php5/cli/conf.d/20-custom.ini  
  
RUN mkdir -p /var/www/html  
  
# Copy joomla files and database dump file  
COPY html/ /var/www/html  
COPY dump.sql /dump.sql  
  
RUN service mysql start \  
&& mysql -u root -proot -e 'CREATE DATABASE joomla;' \  
&& mysql -u root -proot joomla < /dump.sql \  
&& rm /dump.sql  
  
# Configure Apache  
VOLUME ["/var/log/apache2", "/var/www/html"]  
  
COPY ./run.sh /run.sh  
CMD sh /run.sh  

