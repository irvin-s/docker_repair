FROM debian

RUN apt-get update

RUN apt-get install -y \
  lua5.2 \
  liblua5.2-dev \
  luarocks \
  git \
  libssl1.0-dev \
  make

ADD Makefile .
RUN make setup

ADD kong-plugin-template-transformer-*.rockspec .
