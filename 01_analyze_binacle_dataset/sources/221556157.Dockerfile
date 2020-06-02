FROM        debian:buster-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Installation
RUN         apt update && \
            apt upgrade -y && \
            # Install requirements
            apt install -y --no-install-recommends apache2 && \
            # Clean
            apt clean && \
            apt autoremove -y && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

# COnfiguration
COPY        vhost.conf /etc/apache2/sites-available/vhost.conf
RUN         a2enmod actions proxy_fcgi rewrite && \
            a2dissite 000-default.conf && \
            a2ensite vhost.conf && \
            mkdir /var/lib/php-fcgi


RUN         chmod 644 /var/log/apache2

ENV         APACHE_UID 33
ENV         APACHE_GID 33

EXPOSE      80

COPY        run.sh     /run.sh
RUN         chmod u+x  /run.sh

CMD         ["/run.sh"]
