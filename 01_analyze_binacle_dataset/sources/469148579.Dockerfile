FROM kylemanna/bitcoind

# TOR
RUN apt-get update && apt-get install -y tor pwgen dialog

RUN mkdir -p /var/run/tor
RUN chown -R debian-tor:debian-tor /var/run/tor

RUN usermod -a -G debian-tor bitcoin

COPY docker-entrypoint.sh /usr/local/bin/
COPY torrc /etc/tor/torrc
