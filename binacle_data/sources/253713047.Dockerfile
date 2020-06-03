FROM nginx:stable

MAINTAINER Michał Kruczek <mkruczek@pgs-soft.com>

COPY ./php.conf /etc/nginx/conf.d/default.conf

ENV PROJECT_NAME demo
ENV PROJECT_WEB_DIR web
ENV PROJECT_INDEX_FILE index.php
ENV PROJECT_DEV_INDEX_FILE index_dev.php

EXPOSE 80

VOLUME /var/www
WORKDIR /var/www

COPY entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
