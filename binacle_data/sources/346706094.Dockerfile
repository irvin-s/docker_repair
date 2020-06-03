#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
FROM maxexcloo/nginx-php:latest 

# Install Redis.
RUN mkdir /data/http/

ADD index.php /data/http/
ADD env.sh    /data/http/
ADD php.ini.cli  /etc/php5/cli/php.ini
ADD php.ini.fpm  /etc/php5/fpm/php.ini
