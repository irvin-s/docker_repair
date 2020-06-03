FROM drewfle/laravel-dockerstead-minimal:latest  
MAINTAINER Andrew Liu  
  
# Install composer with laravel  
ENV PATH $PATH:/root/.composer/vendor/bin  
RUN curl -sS https://getcomposer.org/installer | php && \  
mv composer.phar /usr/local/bin/composer && \  
composer global require "laravel/installer"  
  
RUN apk upgrade -U  
  
RUN apk --repository=http://nl.alpinelinux.org/alpine/edge/main \  
\--update add \  
boost \  
boost-program_options \  
icu-libs # required by php7-intl  
  
RUN apk --update \  
\--repository=http://nl.alpinelinux.org/alpine/edge/testing add \  
php7-xsl \  
php7-intl \  
php7-ctype \  
php7-mongodb  
  
RUN apk --repository=http://nl.alpinelinux.org/alpine/3.3/main \  
\--update add \  
mysql \  
mysql-client \  
git \  
openssh \  
graphviz  
  
RUN apk --repository=http://nl.alpinelinux.org/alpine/edge/testing \  
\--update add \  
mongodb \  
mongodb-tools  
  
ENV TERM dumb  
WORKDIR /run  
RUN mysql_install_db --user=mysql && \  
mkdir mysqld && \  
chmod -R 755 mysqld && \  
chown -R mysql:mysql mysqld  
WORKDIR /  
COPY mysql-homestead /  
RUN mysqld --datadir='/var/lib/mysql' \--user=mysql & \  
sleep 2s && \  
mysql < mysql-homestead  
  
WORKDIR /etc/php7/conf.d  
RUN sed -i "$ a opcache.load_comments=1" 00_opcache.ini  
  
#VOLUME ["/data/db"]  
#VOLUME ["/var/lib/mysql"]  
#VOLUME ["/var/lib/redis"]  
EXPOSE 80 443 3306 6379 27017 28017  
# Configure Supervisor  
WORKDIR /  
COPY supervisord.conf /etc/supervisor/  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]  

