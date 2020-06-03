FROM telephoneorg/debian:stretch

MAINTAINER Joe Black <me@joeblack.nyc>

ARG     KAMAILIO_INSTALL_MODS

ENV     KAMAILIO_INSTALL_MODS=${KAMAILIO_INSTALL_MODS:-extra,kazoo,outbound,presence,tls,websocket}

LABEL   app.kamailio.version=5.0.x
LABEL   app.kamailio.mods=$KAMAILIO_INSTALL_MODS

ENV     APP kamailio
ENV     USER $APP
ENV     HOME /var/run/$APP

COPY    build.sh /tmp/
RUN     /tmp/build.sh

COPY    entrypoint /
COPY    kamailio.limits.conf /etc/security/limits.d/
COPY    50-kamailio-functions.sh /etc/profile.d/
COPY    goss /goss

ENV     KAMAILIO_LOG_LEVEL info
ENV     KAMAILIO_ENABLE_ROLES=websockets,message

# SIP-TCP / SIP-UDP / SIP-TLS
EXPOSE  5060 5060/udp 5061

# WS-TCP / WS-UDP / WSS-TCP / WSS-UDP
EXPOSE  5064 5064/udp 5065 5065/udp

# ALG-TCP / ALG-UDP / ALG-TLS
EXPOSE  7000 7000/udp 7001

VOLUME  ["/volumes/kamailio/db", "/volumes/kamailio/tls"]

WORKDIR $HOME

SHELL       ["/bin/bash"]
HEALTHCHECK --interval=10s --timeout=5s \
    CMD goss -g /goss/goss.yaml validate || exit 1

ENTRYPOINT  ["/dumb-init", "--"]
CMD         ["/entrypoint"]
