FROM alpine:3.4

ARG EMQTTD_VERSION
ENV EMQTTD_VERSION=${EMQTTD_VERSION:-1.1.3} \
    EMQTTD_HOME=${EMQTTD_HOME:-/opt/emqttd}

RUN apk add --no-cache --virtual=build-dependencies wget git make erlang-dev erlang-syntax-tools erlang-eunit erlang-crypto erlang-reltool erlang-asn1 erlang-tools erlang-eldap erlang-inets erlang-mnesia erlang-observer erlang-os-mon erlang-public-key erlang-runtime-tools erlang-sasl erlang-ssl erlang-xmerl \
    && apk add --no-cache erlang \
    && EMQTTD_TEMP_DIR=/tmp/emqttd \
    && mkdir -p $EMQTTD_TEMP_DIR \
    && git clone https://github.com/emqtt/emqttd.git $EMQTTD_TEMP_DIR \
    && cd $EMQTTD_TEMP_DIR \
    && git checkout $EMQTTD_VERSION \
    && rm -rf rebar \
    && wget -O rebar https://github.com/rebar/rebar/releases/download/2.6.2/rebar \
    && chmod +x rebar \
    && make && make dist \
    && mkdir -p $EMQTTD_HOME \
    && cp -R "${EMQTTD_TEMP_DIR}/rel/emqttd/"* $EMQTTD_HOME \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*

ENV PATH=$PATH:$EMQTTD_HOME/bin

ADD docker-entrypoint.sh /entrypoint.sh

VOLUME ["$EMQTTD_HOME/etc", "$EMQTTD_HOME/log", "$EMQTTD_HOME/data"]

WORKDIR $EMQTTD_HOME

EXPOSE 1883 8883 8083 18083

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start-with-log"]