FROM debian:jessie  
  
MAINTAINER Christian Luginbühl <dinkel@pimprecords.com>  
  
ENV NGINX_VERSION 1.6.2  
ENV PHP_VERSION 5.6.29  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \  
ca-certificates \  
nginx=${NGINX_VERSION}* \  
php5-fpm=${PHP_VERSION}* && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log && \  
ln -sf /dev/stderr /var/log/php-fpm.log  
  
RUN rm -rf /var/www/  
  
COPY nginx.conf /etc/nginx/  
  
COPY default.conf /etc/nginx/conf.d/  
  
COPY www.conf /etc/php5/fpm/pool.d/  
  
EXPOSE 80  
COPY run.sh /  
  
CMD ["/run.sh"]  

