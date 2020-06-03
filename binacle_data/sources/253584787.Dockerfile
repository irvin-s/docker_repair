FROM debian:jessie
MAINTAINER "Magento"

RUN apt-get update && apt-get install -y apt-utils varnish vim && mkdir /etc/varnish/default

COPY conf/default.vcl /etc/varnish/default/default.vcl

COPY conf/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
