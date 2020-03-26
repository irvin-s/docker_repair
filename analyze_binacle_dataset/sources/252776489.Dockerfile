FROM webdevops/php-nginx:debian-9  
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-upgrade -y \  
git-core php-pear libyaml-dev \  
memcached libmemcached-tools libmemcached-dev php7.0-dev  
  
# Install YAML extension  
RUN pecl install yaml-2.0.2  
RUN echo "extension=yaml.so" >> /opt/docker/etc/php/php.ini  
  
COPY ./grav.vhost.conf /opt/docker/etc/nginx/vhost.conf  

