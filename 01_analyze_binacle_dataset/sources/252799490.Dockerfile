# Build:  
# docker build -t phpiniscan .  
#  
# Run:  
# Put your php.ini to check to /tmp/php.ini then run  
#  
# docker run --rm -ti -v /tmp/php.ini:/tmp/php.ini phpiniscan  
FROM ubuntu:14.04  
RUN apt-get update && apt-get -y install php5-cli \  
curl \  
git  
  
RUN curl -sS https://getcomposer.org/installer | php  
RUN ./composer.phar global require psecio/iniscan  
  
CMD ~/.composer/vendor/bin/iniscan scan --path=/tmp/php.ini  

