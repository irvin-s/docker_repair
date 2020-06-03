FROM calfater/base-image:latest  
  
ARG PHP_VERSION=7.0  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN apt-get install -y php${PHP_VERSION}-fpm  
RUN apt-get install -y php${PHP_VERSION}-mysql  
RUN apt-get install -y php${PHP_VERSION}-gd  
RUN apt-get install -y php${PHP_VERSION}-mbstring  
  
ENV PHP_VERSION=${PHP_VERSION}  
ENV PUID=1000  
ENV PGID=1000  
WORKDIR /home/nginx-php  
ENTRYPOINT ["/home/nginx-php/start.sh"]  
VOLUME ["/config", "/www"]  
EXPOSE 80  
# Configure nginx config dir  
RUN mkdir -p /config/nginx  
RUN rm -rf /etc/nginx/sites-enabled  
RUN ln -s /config/nginx /etc/nginx/sites-enabled  
  
# Web directory  
RUN mkdir -p /www  
  
# Makes nginx log to std(out|err)  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
# The default site's configuration  
COPY ["default", "default"]  
RUN sed -i s/PHP_VERSION/$PHP_VERSION/g default  
  
# Startup script  
COPY ["start.sh", "start.sh"]  
RUN ["chmod", "+x", "start.sh"]  
  

