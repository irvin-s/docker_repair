  
FROM advice/ubuntu  
  
ENV TERM xterm  
ENV DEBIAN_FRONTEND noninteractive  
  
# install PHP-FPM  
RUN \  
apt-get update && \  
apt-get -y install \  
php5 \  
php5-fpm \  
php5-cli \  
php5-dev \  
php5-redis \  
php5-mongo \  
php5-gd \  
php5-curl \  
php5-mcrypt \  
php5-oauth \  
&& rm -rf /var/lib/apt/lists/*  
  
# enable PHP mcrypt extension  
RUN php5enmod mcrypt  
  
# display errors  
RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php5/fpm/php.ini  
  
COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf  
  
CMD ["php5-fpm", "-F"]  
  

