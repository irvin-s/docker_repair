FROM alpine:3.4

ARG MOSQUITTO_VERSION
ENV MOSQUITTO_VERSION=${MOSQUITTO_VERSION:-1.4.8} \
    MOSQUITTO_CONF_DIR=/etc/mosquitto

# COMPILE MOSQUITTO
RUN apk add --no-cache --virtual=build-dependencies wget tar build-base util-linux-dev c-ares-dev libwebsockets-dev openssl-dev \
    && apk add --no-cache libwebsockets openssl libuuid \
    && MOSQUITTO_TEMP_DIR=/tmp/mosquitto \
    && mkdir -p $MOSQUITTO_TEMP_DIR \
    && wget -O - http://mosquitto.org/files/source/mosquitto-${MOSQUITTO_VERSION}.tar.gz | tar xzf - -C $MOSQUITTO_TEMP_DIR --strip-components=1 \
    && make -C $MOSQUITTO_TEMP_DIR \
            PREFIX=/usr \
            WITH_SRV=no \
            WITH_WEBSOCKETS=yes \
            WITH_DOCS=no \
    && addgroup mosquitto \
    && adduser -S -H -s /sbin/nologin -D -g mosquitto mosquitto \
    && cp $MOSQUITTO_TEMP_DIR/client/mosquitto_pub /usr/bin/mosquitto_pub \
    && cp $MOSQUITTO_TEMP_DIR/client/mosquitto_sub /usr/bin/mosquitto_sub \
    && cp $MOSQUITTO_TEMP_DIR/src/mosquitto_passwd /usr/bin \
    && cp $MOSQUITTO_TEMP_DIR/src/mosquitto /usr/sbin \
    && cp $MOSQUITTO_TEMP_DIR/lib/libmosquitto.so.1 /usr/lib \
    && mkdir -p $MOSQUITTO_CONF_DIR \
    && cp $MOSQUITTO_TEMP_DIR/mosquitto.conf $MOSQUITTO_CONF_DIR \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*


VOLUME ["$MOSQUITTO_CONF_DIR"]

ENTRYPOINT ["mosquitto"]
