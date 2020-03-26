FROM debian:jessie  
  
MAINTAINER cedric.olivier@free.fr  
  
RUN apt-get update && apt-get install -y \  
curl \  
nginx-common \  
nginx-full \  
php5-fpm \  
php5-mysql \  
supervisor \  
unzip \  
wget  
  
# installation nginx  
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf  
  
RUN mkdir -p /var/www/html && \  
cd /var/www/html && \  
wget -O agora.zip https://www.agora-project.net/divers/download.php && \  
unzip agora.zip  
  
RUN chown -R www-data:www-data /var/www/html  
  
COPY nginx_default /etc/nginx/sites-available/default  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
CMD ["/usr/bin/supervisord"]  
  
EXPOSE 80  
EXPOSE 443  

