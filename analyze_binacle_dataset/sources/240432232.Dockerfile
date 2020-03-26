FROM appscode/ubuntu:16.04

# Install strongswan and etcdctl
RUN set -x \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    strongswan \
    strongswan-ikev2 \
    libstrongswan-standard-plugins libstrongswan-extra-plugins libcharon-extra-plugins \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/*

# Install confd
COPY swanc /usr/bin/swanc

# Setup runit scripts
COPY sv /etc/sv/
RUN ln -s /etc/sv /etc/service

COPY runit.sh /runit.sh
ENTRYPOINT ["/runit.sh"]
EXPOSE 4500/udp 500/udp
