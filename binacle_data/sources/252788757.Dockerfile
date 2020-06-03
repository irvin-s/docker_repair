FROM alpine:3.7  
LABEL description="A Docker image based on Alpine Linux for running nginx"  
LABEL maintainer="n.vasic@cubeteam.com"  
  
RUN apk --update add \  
nginx \  
zip \  
unzip \  
git \  
supervisor \  
&& rm -rf /var/cache/apk/*  
  
# Add user and group for nginx and php-fpm  
# 82 is the standard uid/gid for "www-data" in Alpine  
RUN getent group www-data || addgroup -g 82 -S www-data  
RUN id -u www-data &> /dev/null || adduser -u 82 -D -S -G www-data www-data  
  
# Create temp directory for nginx  
RUN mkdir /tmp/nginx  
RUN chown www-data:www-data /tmp/nginx  
  
# Change user/group for existing nginx directories  
RUN chown www-data:www-data /var/lib/nginx  
RUN chown -R www-data:www-data /var/tmp/nginx  

