FROM elixir:1.5.1

ENV NODE_VERSION 10
ENV PHOENIX_VERSION 1.4.0

RUN apt-get update \
    && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash \
    && apt-get install -y nodejs inotify-tools

RUN mkdir /myapp
WORKDIR /myapp

RUN wget http://download.redis.io/releases/redis-5.0.3.tar.gz \
    && tar xzf redis-5.0.3.tar.gz \
    && cd redis-5.0.3 \
    && make

ADD . /myapp

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
RUN cd assets && npm install
