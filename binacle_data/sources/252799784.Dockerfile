# pitcher-file-deploy  
FROM php:5.6-apache  
RUN usermod -u 1000 www-data #so it can access OSX folders  
RUN apt-get update && apt-get install -y git zip  
RUN mkdir /var/www/html/downloads/  
RUN mkdir /gitrepos  
# VOLUME /var/www/html/downloads/  
# VOLUME /gitrepos  
COPY src/ /var/www/html/  
COPY ssh/ /var/www/.ssh/  
RUN chown -R www-data:www-data /var/www/.ssh/  
RUN chmod -R 0644 /var/www/.ssh/  
RUN chmod 0600 /var/www/.ssh/id_rsa  
RUN chmod 0700 /var/www/.ssh  
RUN chmod 0700 /gitrepos  
RUN chmod 0700 /var/www/html/downloads  
RUN chown -R www-data:www-data /var/www/  
RUN chown -R www-data:www-data /gitrepos

