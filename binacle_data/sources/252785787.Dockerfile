FROM phpmyadmin/phpmyadmin  
  
COPY conf/nginx.conf /etc/nginx.conf  
COPY conf/php.ini /etc/php.ini  
COPY conf/php-fpm.conf /etc/php-fpm.conf  
COPY conf/config.inc.php /etc/phpmyadmin/config.inc.php

