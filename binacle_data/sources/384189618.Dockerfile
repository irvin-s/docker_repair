FROM debian:jessie
RUN apt-get update && apt-get install -y libxml2-dev libpam-dev libsqlite3-dev clearsilver-dev libcurl3-dev libgmp-dev libfcgi-dev libcap2 ipsec-tools libsoup2.4-dev libmysqlclient-dev wget
RUN groupadd vpn

ADD strongswan_5.1.1-1_amd64.deb /tmp/
RUN dpkg -i /tmp/strongswan_5.1.1-1_amd64.deb
RUN mkdir -p /etc/ipsec.d/conf && touch /etc/ipsec.d/conf/placeholder.conf
RUN mkdir -p /etc/ipsec.d/aacerts && mkdir -p /etc/ipsec.d/cacerts && mkdir -p /etc/ipsec.d/crls && mkdir -p /etc/ipsec.d/ocspcerts && mkdir -p /etc/ipsec.d/acerts
RUN echo "include /etc/ipsec.d/conf/*.conf" >> /etc/ipsec.conf

ADD ipsec_start /usr/local/bin/ipsec_start
ADD pipework /usr/local/bin/pipework

VOLUME /etc/ipsec.d

EXPOSE 500

ENTRYPOINT ["/usr/local/bin/ipsec_start"]
CMD []
