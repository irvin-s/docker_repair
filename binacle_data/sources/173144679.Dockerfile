# Docker image to build wave with docker/alpine/erlang as target

#
# execution:
#   docker build -f tools/docker/Dockerfile.build -t gbour/wave-build .

#NOTE: short-circuiting msaraiva docker to get last alpine(3.4) and erlang (18.3.2) versions
#FROM msaraiva/erlang
FROM alpine:3.4
MAINTAINER Guillaume Bour <guillaume@bour.cc>

RUN apk update
RUN apk add erlang
# needed tools to build release
RUN apk add bash make git
# rebar3 required modules
RUN apk add erlang-syntax-tools
# jiffy NIF build
RUN apk add g++ libstdc++ erlang-dev
# wave or dependencies required modules
#   erlang-eunit: eredis
RUN apk add erlang-sasl erlang-inets erlang-crypto erlang-ssl erlang-public-key erlang-asn1 erlang-mnesia \
            erlang-eunit erlang-snmp

