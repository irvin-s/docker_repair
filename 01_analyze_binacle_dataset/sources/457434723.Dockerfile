FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
        build-essential \
        apache2 apache2-utils libxml2 libxml2-dev \
        wget curl unzip jq \
	&& rm -r /var/lib/apt/lists/*

RUN a2enmod ssl headers proxy proxy_http rewrite proxy_balancer proxy_connect remoteip lbmethod_byrequests proxy_wstunnel

COPY apache.conf /etc/apache2/sites-enabled/000-default.conf
RUN echo "Servername localhost">>/etc/apache2/apache2.conf

# NB: Assuming ELB in front that terminates HTTPS
# Custom build of mod_auth_pubtkt (reads "X-Forwarded-For" -header)
COPY mod_pubtkt.deb /tmp
RUN dpkg -i /tmp/mod_pubtkt.deb
RUN echo "LoadModule auth_pubtkt_module /usr/lib/apache2/modules/mod_auth_pubtkt.so">>/etc/apache2/mods-enabled/auth_pubtkt.load
RUN echo "TKTAuthPublicKey /etc/apache2/tkt_pubkey.pem">>/etc/apache2/mods-enabled/auth_pubtkt.conf
COPY tkt_pubkey.pem /etc/apache2/tkt_pubkey.pem

COPY status.html /var/www/html/status.html
COPY index.html /var/www/html/index.html

ENV APACHE_LOG_DIR /tmp

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
