FROM socialengine/php-apache:5.6

ENV VOLUME_PATH /test/public

COPY . /test

RUN chown www-data:www-data -R /test
