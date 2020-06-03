#####################################################################  
# broadtech/alpine-php-fpm  
# This Dockerfile creates an inage that deploys php7-fpm  
# on Alpine Linux  
  
# Base Image  
FROM alpine  
  
LABEL "vendor"="BroadTech Innovations PVT LTD"  
LABEL "vendor.url"="http://www.broadtech-innovations.com/"  
LABEL "maintainer.name"="Siju Oommen George"  
LABEL "maintainer.email"="sgeorge.ml@gmail.com"  
  
# Upgrade existing packages in the base image  
RUN apk --no-cache upgrade  
  
# Install php-fpm from packages with out caching install files  
RUN apk add --no-cache php7-fpm  
  
# Uncomment below to add the php packages you need  
# For a full list of php packages vist  
# https://pkgs.alpinelinux.org/packages?name=php7*  
  
# RUN apk add --no-cache \  
# php7-mbstring \  
# php7-mcrypt \  
# php7-json \  
# php7-gd \  
# php7-bz2 \  
# php7-ctype \  
# php7-zlib \  
# php7-zip \  
# php7-mysqli \  
# php7-pgsql \  
#  
  
# Copy configuration files  
COPY conf/php-fpm.conf /etc/php7/  
COPY conf/www.conf /etc/php7/php-fpm.d/  
  
# Create directory for php files.  
RUN mkdir -p /var/www/localhost/htdocs/  
COPY www/index.php /var/www/localhost/htdocs/  
RUN chmod -R +x /var/www/localhost/htdocs/  
  
# Add entrypoint scripts and make them executable  
RUN mkdir /etc/docker-entrypoint.d  
COPY docker-entrypoint.d/* /etc/docker-entrypoint.d/  
RUN chmod u+x /etc/docker-entrypoint.d/*  
  
COPY scripts/run_parts_entrypoint.sh /usr/sbin/  
RUN chmod u+x /usr/sbin/run_parts_entrypoint.sh  
  
# Open port to access FPM  
EXPOSE 9000  
  
# Run PHP-FPM when container starts  
CMD ["/usr/sbin/run_parts_entrypoint.sh"]  
  
# -------------------------END----------------------------------------#  

