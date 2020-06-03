FROM ubuntu:xenial

ENV LOG_LEVEL "DEBUG"
ENV DB_HOST "localhost"
ENV DB_PORT "3306"
ENV DB_USER "root"
ENV DB_PASSWORD ""
ENV DB_NAME "steem"


WORKDIR /app

RUN set -ex; \
	apt-get update && apt-get dist-upgrade -y --no-install-recommends; \
	apt-get install -y wget nano git; \
	apt-get install -y --no-install-recommends php7.0-cli php7.0-zip php7.0-mcrypt php7.0-mbstring php7.0-intl php7.0-bz2 php7.0-bcmath php7.0-xml php7.0-mysql php7.0-json php7.0-gd php7.0-curl; \
	apt-get install -y --no-install-recommends language-pack-en;

RUN git clone https://dev.quiqqer.com/pcsg/steem-blockchain-parser.git /app/

RUN mv /app/etc/config.ini.php.dist /app/etc/config.ini.php

RUN wget -O /usr/local/bin/composer https://getcomposer.org/download/1.6.3/composer.phar
RUN chmod +x /usr/local/bin/composer

RUN composer install

ADD start.sh /app/
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
