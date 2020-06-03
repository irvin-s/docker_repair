FROM canelrom1/debian-canel:latest  
  
LABEL maintainer="Rom1 <rom1@canel.ch> \- CANEL - https://www.canel.ch"  
LABEL date="27/01/18"  
LABEL description="Serveur HTTP - apache2"  
  
RUN apt-get update \  
&& apt-get -y -q --no-install-recommends \  
install apache2 \  
openssl  
  
RUN rm -fr /var/www/html/* \  
&& rm -fr /etc/apache2/sites-enabled/* \  
&& mkdir -p /etc/ssl/apache2/ \  
&& a2enmod ssl \  
&& a2enmod headers \  
&& openssl req -x509 -newkey rsa:4086 \  
-subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \  
-keyout "/etc/ssl/apache2/www.key" \  
-out "/etc/ssl/apache2/www.crt" \  
-days 3650 -nodes -sha256 \  
&& echo 'ServerTokens Prod' > /etc/apache2/conf-available/security.conf \  
&& echo 'ServerSignature Off' >> /etc/apache2/conf-available/security.conf \  
&& echo 'TraceEnable Off' >> /etc/apache2/conf-available/security.conf  
  
COPY ./conf/html/* /var/www/html/  
COPY ./conf/robots.txt /var/www/  
COPY ./conf/apache2.conf /etc/apache2/apache2.conf  
COPY ./conf/000-default.conf /etc/apache2/sites-enabled/000-default.conf  
COPY ./conf/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf  
  
RUN ln -s /var/www/robots.txt /var/www/html \  
&& chown -R www-data:www-data /var/www/html  
  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_PID_FILE /var/run/apache2.pid  
ENV APACHE_RUN_DIR /var/run/  
ENV APACHE_LOCK_DIR /var/lock/  
ENV APACHE_LOG_DIR /var/log/apache2  
  
VOLUME /var/www/html  
  
EXPOSE 80  
EXPOSE 443  
COPY ./entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apache2"]  

