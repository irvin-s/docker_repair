FROM eboraas/apache-php:latest

COPY src/ /var/www/html/
COPY key /root/
RUN rm /var/www/html/index.html \
    && chmod -R 655 /var/www/html/ \
    && chmod 444 /root/key
