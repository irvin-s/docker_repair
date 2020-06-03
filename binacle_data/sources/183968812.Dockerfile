FROM php:7.0-cli
COPY . /usr/src/plus-pull/
WORKDIR /usr/src/plus-pull

RUN apt-get update && apt-get -y --no-install-recommends install git unzip
RUN php -r "readfile('https://raw.githubusercontent.com/composer/getcomposer.org/c1ad3667731e9c5c1a21e5835c7e6a7eedc2e1fe/web/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN composer install

CMD [ "php", "/usr/src/plus-pull/bin/pluspull.php" ]
