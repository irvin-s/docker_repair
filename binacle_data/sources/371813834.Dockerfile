FROM ubuntu:14.04
MAINTAINER Tibor Sári <tiborsari@gmx.de>

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update -qqy && \
    apt-get install --no-install-recommends -qqy \
        openvpn \
        python \
        squid \
        squidview \
        supervisor \
        wget \
        $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY update-resolv-conf /etc/openvpn/update-resolv-conf
COPY openvpn-disconnect /usr/local/bin/openvpn-disconnect
RUN chmod +x /etc/openvpn/update-resolv-conf && chmod +x /usr/local/bin/openvpn-disconnect

VOLUME ["/vpn"]

RUN squid3 -z -F

COPY squid.conf /etc/squid/squid.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3128

# Set up the command arguments
CMD ["/usr/bin/supervisord"]
