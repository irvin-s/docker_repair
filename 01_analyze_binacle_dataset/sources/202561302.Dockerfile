FROM resin/rpi-raspbian:wheezy

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    openssl \
    pianobar \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -m 0750 -p ~/.config/pianobar

ADD config ~/.config/pianobar/config

ADD tls_fingerprint.sh /bin/tls_fingerprint.sh

RUN echo "tls_fingerprint = `tls_fingerprint.sh`" >> ~/.config/pianobar/config

CMD ["pianobar"]
