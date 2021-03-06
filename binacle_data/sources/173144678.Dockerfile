
#
# tar czh . |docker build -f tools/docker/Dockerfile -t gbour/wave - 
#
FROM alpine:3.4
MAINTAINER Guillaume Bour <guillaume@bour.cc>

RUN apk update
RUN apk add erlang
RUN apk add libstdc++ 
# wave or dependencies required modules
RUN apk add erlang-sasl erlang-inets erlang-crypto erlang-ssl erlang-public-key erlang-asn1 \
            erlang-mnesia erlang-syntax-tools erlang-eunit erlang-snmp

#
# wave is store in /opt/wave
#   lib/ contains libraries
#   wave.config is the configuration files

#   entrypoint.sh is the startuo script (stored in /usr/local/bin)
#
RUN mkdir -p /opt/wave/bin /opt/wave/lib /opt/wave/etc
COPY _build/alpine/lib /opt/wave/lib
COPY bin/mkpasswd /opt/wave/bin/
COPY .wave.alpine.config /opt/wave/wave.config
COPY tools/docker/entrypoint.sh /usr/local/bin

# MQTT ports
#   . 1883: tcp
#   . 8883: ssl
#   . 1884: websocket
#   . 8884: websocket (ssl)
EXPOSE 1883 8883 1884 8884

ENTRYPOINT ["entrypoint.sh"]
