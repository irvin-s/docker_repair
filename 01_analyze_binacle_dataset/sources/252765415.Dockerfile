############################################################  
# Dockerfile to build php-fpm container images  
# Based on Ubuntu  
############################################################  
# Set the base image to Ubuntu  
FROM ubuntu  
# File Author / Maintainer  
MAINTAINER hieutrinh <trieuhieu509a@gmail.com>  
# Update the repository sources list  
RUN apt-get update -y && \  
apt-get install -y \  
php-fpm php-mysql  
  
VOLUME [ "/var/www/html" ]  
  
WORKDIR /var/www/html  
  
EXPOSE 9000  
  
  
  
CMD ["php-fpm"]  

