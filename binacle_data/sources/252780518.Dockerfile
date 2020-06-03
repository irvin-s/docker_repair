FROM nimmis/apache-php5  
MAINTAINER Michael Garrez <michael.garrez@gmail.com>  
  
ENV REFRESHED_AT 2015-05-11  
RUN usermod -u 1000 www-data  
RUN mkdir -p /var/www/html  
RUN apt-get update  
RUN yes | apt-get upgrade  
RUN apt-get install -y php5-dev php5-cli php-pear  
RUN printf "\n" | pecl install mongo  
RUN echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini  
RUN cp /etc/php5/mods-available/mongo.ini /etc/php5/apache2/conf.d/  
RUN cp /etc/php5/mods-available/mongo.ini /etc/php5/cli/conf.d/  
RUN a2enmod rewrite  
ENV TERM xterm  
  
EXPOSE 80  
CMD ["apache2ctl", "-D", "FOREGROUND"]  

