FROM debian:jessie

RUN apt-get update && \
    apt-get install -y curl
RUN curl -sL https://github.com/rancher/compose-templates/raw/master/utils/containers/confd/confd-0.11.0-dev-rancher-linux-amd64 > /usr/bin/confd
RUN chmod +x /usr/bin/confd

VOLUME /var/www/config
VOLUME /var/www/play
VOLUME /var/www/rest
VOLUME /var/lib/mysql

COPY ./var /etc/confd/templates/var/
COPY setup.sh /

ENTRYPOINT ["/setup.sh"]
CMD ["confd", "--backend", "rancher", "--prefix", "/2015-07-25"]
