FROM canelrom1/apache2:latest  
  
LABEL maintainer="rom1 <rom1@canel.ch> \- CANEL - https://www.canel.ch"  
LABEL date="27/01/18"  
LABEL description="Serveur HTTP + PHP5: apache2"  
  
RUN apt-get update \  
&& apt-get -y -q --no-install-recommends \  
install libapache2-mod-php7.0 \  
php7.0 \  
php7.0-mbstring \  
php7.0-mysql \  
php7.0-xml  
  
RUN a2enmod php7.0  
  
COPY ./conf/html/phpinfo.php /var/www/html  
  
VOLUME /var/www/html  
  
EXPOSE 80  
EXPOSE 443  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apache2"]  

