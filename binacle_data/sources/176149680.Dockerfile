FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    php5-fpm \
    php5-json \
    php5-intl \
    && apt-get clean

ADD start.sh /start.sh
ADD symfony /opt/symfony

EXPOSE 9000
WORKDIR /opt/symfony
VOLUME /opt/symfony

ENTRYPOINT ["/start.sh"]
