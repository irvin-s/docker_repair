# bloomboard/observation-service  
# github: Bloomboard  
FROM ubuntu:precise  
MAINTAINER Bryce Reynolds brycereynoldsdesign@gmail.com  
  
# Get rid of the cannot change locale error message on login  
RUN locale-gen en_US.UTF-8  
RUN echo LANG=en_US.UTF-8 > /etc/default/locale  
  
# Update package list  
RUN apt-get -qqy update && DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get install -qy python-software-properties \  
&& add-apt-repository -y ppa:ondrej/php5-oldstable \  
&& add-apt-repository -y ppa:nginx/stable \  
&& add-apt-repository -y ppa:chris-lea/node.js  
  
RUN apt-get -qqy update && DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get install -qy \  
curl \  
vim \  
unzip \  
git \  
openssh-server \  
libssh2-php \  
mysql-client \  
nginx \  
php5-fpm \  
php5-mysql \  
php-apc \  
php5-imagick \  
php5-imap \  
php5-mcrypt \  
php5-gd \  
php5-cli \  
php5-curl \  
php-pear \  
php5-xdebug \  
php5-sqlite \  
nodejs \  
aria2  
  
# Setup SSH  
RUN mkdir /var/run/sshd  
ENV ROOT_PASS unset  
  
# Add motd  
RUN rm -f /etc/motd  
ADD motd /etc/motd  
  
# Node and dependencies  
RUN npm -y -g install less@1.7.5 coffee-script uglify-js grunt-cli bower  
  
# PHPUnit  
RUN wget https://phar.phpunit.de/phpunit.phar  
RUN chmod +x phpunit.phar  
RUN mv phpunit.phar /usr/local/bin/phpunit  
  
# PHP files - now using volume mounting  
RUN cp /etc/php5/fpm/php.ini /etc/php5/fpm/php.ini.bak  
RUN cp /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf.bak  
  
# PHP extensions  
ADD /php5/fpm/conf.d/redis.ini /etc/php5/fpm/conf.d/redis.ini  
ADD /php5/fpm/conf.d/xdebug.ini /etc/php5/mods-available/xdebug.ini  
  
# Setup folders for xdebug  
RUN mkdir -p -m 777 /var/xdebug  
RUN mkdir -p -m 777 /var/xdebug/profiler  
RUN mkdir -p -m 777 /var/xdebug/trace  
  
# Redis  
ADD /redis.so /usr/lib/php5/20100525/redis.so  
  
# Add nginx configs - now using volume mounting  
RUN cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak  
  
# Set-up term user  
RUN useradd -d /home/term -m -s /bin/bash term  
RUN echo 'term:term' | chpasswd  
RUN adduser term sudo  
  
WORKDIR /  
  
# We add standard .sh scripts to root. Make those executable.  
ADD /startup.sh /startup.sh  
RUN chmod 755 /*.sh && chmod +x /*.sh  
  
EXPOSE 22 80 443  
ENTRYPOINT ["./startup.sh"]  

