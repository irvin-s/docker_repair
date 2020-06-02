FROM bernardolins/php56  
  
ENV RC_VERSION 1.1.2  
RUN apt-get update -y  
RUN apt-get install -y apache2 wget php5-pgsql  
  
COPY roundcubemail-$RC_VERSION-complete.tar.gz /tmp/roundcube.tar.gz  
  
WORKDIR /tmp  
  
RUN tar -xzvf roundcube.tar.gz -C /var/www/html &&\  
mv /var/www/html/roundcubemail-$RC_VERSION /var/www/html/roundcube  
  
RUN chown -R www-data.www-data /var/www/html/roundcube/temp &&\  
chown -R www-data.www-data /var/www/html/roundcube/logs  
  
WORKDIR /etc/apache2  
  
RUN php5enmod mcrypt  
  
EXPOSE 80  
CMD service apache2 start && tail -f /var/log/apache2/error.log

