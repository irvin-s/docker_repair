FROM ubuntu:14.04

MAINTAINER Dan Isla "https://github.com/danisla/dockerfiles/openvpn-as"

RUN apt-get update && apt-get install -y --no-install-recommends \
    jq curl iptables

# Install Tini
RUN curl -skL https://github.com/krallin/tini/releases/download/v0.6.0/tini > tini && \
    echo "d5ed732199c36a1189320e6c4859f0169e950692f451c03e7854243b95f4234b *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV OPENVPN_AS_VER 2.0.24

RUN curl -sfL -o /tmp/openvpn-as.deb http://swupdate.openvpn.org/as/openvpn-as-${OPENVPN_AS_VER}-Ubuntu14.amd_64.deb && \
 dpkg -i /tmp/openvpn-as.deb

# Set default password
RUN echo "openvpn:password1234" | chpasswd

EXPOSE 443/tcp 1194/udp 943/tcp

VOLUME ["/usr/local/openvpn_as/etc/db"]

ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["tini", "--"]
CMD ["/usr/local/bin/start.sh"]
