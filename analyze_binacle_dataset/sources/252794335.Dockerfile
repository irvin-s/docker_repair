FROM dasrick/docker-php-base-wbc:5.6.18  
MAINTAINER Alexander Miehe <alexander.miehe@gmail.com>  
  
RUN apt-get install -y php5-xdebug && apt-get autoclean  
  
ADD xdebug.ini /etc/php5/cli/conf.d/100-xdebug.ini  
ADD xdebug.ini /etc/php5/fpm/conf.d/100-xdebug.ini  
ADD xdebug /usr/local/bin/xdebug  
RUN chmod +x /usr/local/bin/xdebug

