FROM resin/rpi-raspbian:jessie

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    festival \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

CMD ["echo", "'this is a text to speech test'", "|", "festival", "--tts"]
