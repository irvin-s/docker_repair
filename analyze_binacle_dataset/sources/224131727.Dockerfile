FROM php:5.6-fpm

RUN rm /usr/local/etc/php-fpm.conf
ADD ./php-fpm.conf /usr/local/etc/
ADD ./index.php /var/www/html/

CMD ["php-fpm"]
