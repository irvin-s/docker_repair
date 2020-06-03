FROM alpine:3.6  
COPY scripts /scripts  
  
RUN /scripts/install-packages.sh \  
&& /scripts/ensure-www-data.sh \  
&& apk --no-cache add php7-apache2 apache2-utils \  
&& mkdir /run/apache2 \  
&& ln -sfT /dev/stdout "/var/log/apache2/access.log" \  
&& ln -sfT /dev/stderr "/var/log/apache2/error.log" \  
&& rm -rf /scripts  
  
COPY ./7-apache/httpd.conf /etc/apache2/httpd.conf  
COPY ./7-apache/app.vhost.conf /etc/apache2/conf.d/zzz-app.vhost.conf  
COPY /scripts/enable-xdebug.sh /usr/local/bin/enable-xdebug  
COPY files/xdebug.ini /etc/php7/conf.d/xdebug.ini  
  
RUN apk add --no-cache tini  
  
EXPOSE 80  
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]  

