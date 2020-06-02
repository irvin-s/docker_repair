FROM alpine:edge  
  
RUN apk update \  
&& apk -U upgrade \  
&& apk add apache2 \  
&& apk add apache2-proxy \  
&& rm -rf /var/cache/apk/*  
  
ENV PHPFPM_HOST ""  
ENV DOCUMENT_ROOT "/var/www/html"  
ENV SERVER_ROOT "/var/apache2"  
ENV DOCUMENT_ROOT_OPTIONS "Indexes FollowSymLinks"  
ENV DOCUMENT_ROOT_ALLOW_OVERRIDE "All"  
ENV DOCUMENT_ROOT_REQUIRE "all granted"  
ENV DIRECTORY_INDEX ""  
RUN rm -rf /var/www/*  
RUN mkdir -p /etc/optional /run/apache2  
  
ADD httpd.conf /etc/apache2/httpd.conf  
ADD php-fpm.conf /etc/optional/php-fpm.conf  
ADD proxy.conf /etc/apache2/conf.d/proxy.conf  
  
ADD docker-entrypoint.sh /usr/sbin/docker-entrypoint.sh  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["httpd", "-DFOREGROUND"]  

