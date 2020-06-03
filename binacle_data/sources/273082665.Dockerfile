FROM debian:stretch-slim

LABEL maintainer="Florent DESPIERRES <florent@despierres.pro> Michael COULLERET <michael@coulleret.pro>"

# Copy all scripts
COPY ./image/scripts /tmp/

# Run all scripts
RUN chmod +x /tmp/*.sh && \
    sh /tmp/env.sh && \
    sh /tmp/common-tools.sh && \
    sh /tmp/php7.0/apt.sh && \
    sh /tmp/js-tools.sh && \
    sh /tmp/composer.sh && \
    sh /tmp/clean.sh

# Copy config
COPY ./image/config /
COPY ./image/7.0/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN rm -f /etc/motd && chmod +x /etc/update-motd.d/* && ln -s /etc/update-motd.d/50-phpdocker /etc/motd

EXPOSE 80 443 9000

WORKDIR /app

USER php

CMD ["sudo", "supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
