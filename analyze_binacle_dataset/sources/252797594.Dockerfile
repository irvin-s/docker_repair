FROM alpine  
  
RUN apk \--no-cache \--update \  
add php5-fpm php5-cli php5-common \  
php5-suhosin php5-mysql php5-mysqli \  
php5-mcrypt php5-gd && \  
ln -s /dev/stdout /var/log/php-fpm.log && \  
sed -i 's/127\.0\.0\.1:9000/\/tmp\/php\.sock/' /etc/php5/php-fpm.conf && \  
sed -i 's/^include/;&/' /etc/php5/php-fpm.conf && \  
sed -i 's/;listen\.mode.*/listen.mode = 0666/g' /etc/php5/php-fpm.conf && \  
rm /var/cache/apk/*  
  
VOLUME ["/tmp"]  
ENTRYPOINT ["php-fpm5","-F","-d","short_open_tag=On"]  

