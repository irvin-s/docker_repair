FROM mhart/alpine-node:latest


# Configuration

ENV ELIXIR_VERSION 1.3.2


# Utils

RUN apk --no-cache add git inotify-tools


# Erlang

RUN apk --no-cache add \
  erlang \
  erlang-asn1 \
  erlang-crypto \
  erlang-dev \
  erlang-erl-interface \
  erlang-eunit \
  erlang-inets \
  erlang-parsetools \
  erlang-public-key \
  erlang-sasl \
  erlang-ssl \
  erlang-syntax-tools \
  erlang-tools


# Elixir

ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN apk --no-cache add --virtual build-dependencies wget ca-certificates \
  && wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip \
  && mkdir -p /opt/elixir-${ELIXIR_VERSION}/ \
  && unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ \
  && rm -rf Precompiled.zip /etc/ssl \
  && apk del build-dependencies

RUN mix local.hex --force && \
  mix local.rebar --force && \
  mix hex.info


# Phoenix

RUN yes | mix archive.install \
  https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez


# Init

WORKDIR /cwd
CMD /bin/sh
