FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y install git nginx nginx-extras php5-dev php5-fpm libpcre3-dev gcc make php5-mysql
RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/index.php

RUN git clone --depth=1 http://github.com/phalcon/cphalcon.git
RUN cd cphalcon/build && ./install;

RUN echo 'extension=phalcon.so' >> /etc/php5/fpm/conf.d/30-phalcon.ini
RUN echo 'extension=phalcon.so' >> /etc/php5/cli/conf.d/30-phalcon.ini

ADD nginx.conf /etc/nginx/nginx.conf
ADD default /etc/nginx/sites-available/default
ADD default-ssl /etc/nginx/sites-enabled/default-ssl

ADD server.crt /etc/nginx/ssl/
ADD server.key /etc/nginx/ssl/

EXPOSE 80

CMD service php5-fpm start && nginx
