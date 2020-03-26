FROM ubuntu:16.04

ENV REPLACE_OS_VARS=true \
    MIX_ENV=prod \
    APP_NAME=test \
    APP_VERSION=0.1.0 \
    TERM=xterm \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN \
    apt-get update && \
    apt-get install -y locales wget && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 && \
    wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
    dpkg -i erlang-solutions_1.0_all.deb && \
    apt-get update && \
    apt-get install -y erlang-dev erlang-parsetools elixir && \
    mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/build

COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile 

COPY . .
RUN \
   mkdir -p /opt/app/log && \
   mix do compile, release --verbose --env=prod && \
   cp _build/prod/rel/$APP_NAME/releases/$APP_VERSION/$APP_NAME.tar.gz /opt/app/$APP_NAME.tar.gz && \
   cd /opt/app && \
   tar -xzf $APP_NAME.tar.gz && \
   chmod -R 777 /opt/app && \
   rm $APP_NAME.tar.gz

WORKDIR /opt/app
   
RUN /bin/sh
