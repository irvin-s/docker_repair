FROM eboraas/apache-php:latest

COPY src/ /var/www/html/

RUN rm /var/www/html/index.html \
    && chmod -R 655 /var/www/html \
    && chmod -R 777 /var/www/html/upload \
    && chmod 655  /var/www/html/upload/index.html
