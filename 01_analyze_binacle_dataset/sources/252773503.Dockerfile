FROM php:7.0-alpine  
  
LABEL maintainer "me@billiam.ca"  
  
RUN set -xe \  
&& curl -O http://get.sensiolabs.org/sami.phar \  
&& chmod a+x sami.phar \  
&& mv sami.phar /usr/local/bin/sami  
  
COPY docker-entrypoint /usr/local/bin/  
  
COPY sami.php /var/local/  
  
WORKDIR /var/local  
  
RUN mkdir src  
  
VOLUME /var/local/src  
  
CMD ["php", "-S", "0.0.0.0:80", "-t", "sami"]  
  
ENTRYPOINT ["docker-entrypoint"]  
  
EXPOSE 80  

