# See https://github.com/webdevops/Dockerfile  
FROM webdevops/php-apache:ubuntu-16.04  
MAINTAINER Alexander Eimer <alexander.eimer@gmail.com>  
  
ENV CONFIG_FILE=/opt/config.json  
  
COPY ./index.php /app/index.php  

