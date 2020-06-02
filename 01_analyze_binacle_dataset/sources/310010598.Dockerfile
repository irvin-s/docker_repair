FROM ubuntu

MAINTAINER Mossaddeque Mahmood

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apache2 \
    nano \
    curl \
    ca-certificates \
    libapache2-mod-evasive \
    libapache2-mod-security2 \
    modsecurity-crs \
    libapache2-mod-jk

RUN mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf

RUN cd /tmp \
    && curl -o /tmp/mod-pagespeed.deb https://dl-ssl.google.com/dl/linux/direct/mod-pagespeed-beta_current_amd64.deb \
    && dpkg -i /tmp/mod-pagespeed.deb \
    && apt-get -f install

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
 -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/C=NL/ST=Amsterdam/L=Amsterdam/O=MM/OU=Development/CN=unloadbrain.com"

RUN a2enmod proxy proxy_http headers expires ssl
RUN service apache2 stop

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY vhost-default.conf /etc/apache2/sites-available/000-default.conf
COPY vhost-default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2ensite default-ssl
RUN a2enmod ssl

RUN service apache2 start

VOLUME ["/var/log/apache2"]
EXPOSE 80 443

ENTRYPOINT ["apache2ctl", "-D", "FOREGROUND"]
