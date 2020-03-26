FROM fantomtest-base:1.0

RUN mkdir /var/www/fantomtest
COPY fantomTest /var/www/fantomtest

ENTRYPOINT ["/docker/script/entrypoint.sh"]
CMD ["nginx-php-fpm"]
