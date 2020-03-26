FROM alpine:3.5

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src

RUN apk add --no-cache bash make git curl erlang erlang-asn1 erlang-crypto erlang-dev erlang-dialyzer erlang-eunit erlang-inets erlang-public-key erlang-sasl erlang-ssl erlang-syntax-tools erlang-tools gcc g++ && \
    git clone https://github.com/erlang/rebar3.git &&\
    cd rebar3 && \
    ./bootstrap &&\
    cp rebar3 /usr/local/bin

WORKDIR /opt/driver/src
