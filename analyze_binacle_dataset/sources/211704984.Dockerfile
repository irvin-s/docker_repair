FROM alpine:3.4

ARG EMQ_VERSION
ENV EMQ_VERSION=${EMQ_VERSION:-v2.0.1} \
    EMQ_HOME=${EMQ_HOME:-/opt/emqttd}

RUN apk add --no-cache --virtual=build-dependencies \
        erlang \
        erlang-public-key \
        erlang-syntax-tools \
        erlang-erl-docgen \
        erlang-gs \
        erlang-observer \
        erlang-ssh \
        erlang-ose \
        erlang-cosfiletransfer \
        erlang-runtime-tools \
        erlang-os-mon \
        erlang-tools \
        erlang-cosproperty \
        erlang-common-test \
        erlang-dialyzer \
        erlang-edoc \
        erlang-otp-mibs \
        erlang-crypto \
        erlang-costransaction \
        erlang-odbc \
        erlang-inets \
        erlang-asn1 \
        erlang-snmp \
        erlang-erts \
        erlang-et \
        erlang-cosnotification \
        erlang-xmerl \
        erlang-typer \
        erlang-coseventdomain \
        erlang-stdlib \
        erlang-diameter \
        erlang-hipe \
        erlang-ic \
        erlang-eunit \
        erlang-webtool \
        erlang-mnesia \
        erlang-erl-interface \
        erlang-test-server \
        erlang-sasl \
        erlang-jinterface \
        erlang-kernel \
        erlang-orber \
        erlang-costime \
        erlang-percept \
        erlang-dev \
        erlang-eldap \
        erlang-reltool \
        erlang-debugger \
        erlang-ssl \
        erlang-megaco \
        erlang-parsetools \
        erlang-cosevent \
        erlang-compiler \
        git \
        make \
        perl \
    \
    && apk add --no-cache \
        ncurses-terminfo-base \
        ncurses-terminfo \
        ncurses-libs \
        readline \
    \
    && EMQ_TEMP_DIR=/tmp/emqttd \
    && mkdir -p $EMQ_TEMP_DIR \
    && git clone -b ${EMQ_VERSION} https://github.com/emqtt/emqttd-relx.git $EMQ_TEMP_DIR \
    && cd $EMQ_TEMP_DIR \
    && make \
    && mkdir -p $EMQ_HOME \
    && cp -R "${EMQ_TEMP_DIR}/_rel/emqttd/"* $EMQ_HOME \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*

ENV PATH=$PATH:$EMQ_HOME/bin

ADD docker-entrypoint.sh /entrypoint.sh

VOLUME ["$EMQ_HOME/etc", "$EMQ_HOME/log", "$EMQ_HOME/data", "$EMQ_HOME/plugins"]

WORKDIR $EMQ_HOME

# emqttd will occupy these port:
# - 1883 port for MQTT
# - 8883 port for MQTT(SSL)
# - 8083 for WebSocket/HTTP
# - 8084 for WSS/HTTPS
# - 18083 for dashboard
# - 4369 for port mapping
# - 6000-6999 for distributed node
EXPOSE 1883 8883 8083 8084 18083 4369 6000-6999

ENTRYPOINT ["/entrypoint.sh"]
CMD ["foreground"]