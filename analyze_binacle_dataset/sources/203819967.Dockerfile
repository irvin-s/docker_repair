FROM resin/armhf-alpine

RUN apk add --update transmission-daemon

ADD ./config /example-config

VOLUME "/config"

CMD cp /example-config/settings.json /config/; /usr/bin/transmission-daemon --foreground --no-portmap --log-error --config-dir /config
