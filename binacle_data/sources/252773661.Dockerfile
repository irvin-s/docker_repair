FROM alledia/codeception-phantomjs  
  
MAINTAINER Alledia <suport@alledia.com>  
  
# Copy joomla files and database dump file  
ADD ./www /var/www/html  
ADD ./dump.sql /dump.sql  
  
RUN rm /var/www/html/index.html  
  
# Configure the MySQL database  
RUN service mysql start \  
&& mysqladmin -u root password root  
  
RUN service mysql start \  
&& mysql -u root -proot -e 'CREATE DATABASE joomla350;' \  
&& mysql -u root -proot joomla350 < /dump.sql \  
&& rm /dump.sql  
  
# Configure Apache  
VOLUME /var/log/apache2/joomla350.dev-error_log  
VOLUME /var/log/apache2/joomla350.dev-access_log  
  
ADD ./run.sh /run.sh  
  
CMD sh /run.sh  

