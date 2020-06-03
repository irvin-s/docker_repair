# this is currently for development purposes only;
# uses root user, so don't use this for deployment

FROM ruby:2.3.4-alpine
MAINTAINER Ben Titcomb <btitcomb@scpr.org>

RUN apk update && apk add --no-cache \
  make \
  gcc \
  libgcc \
  g++ \
  libc-dev \
  libffi-dev \
  git \
  mysql-dev \
  ruby-json \
  yaml \
  zlib-dev \
  libxml2-dev \
  libxslt-dev \
  tzdata \
  yaml-dev \
  openrc \
  libcurl \
  curl-dev \
  openssl \
  nodejs 

# RUN addgroup -S scpr && adduser -S -g scpr scpr 

ENV HOME /home/scpr

WORKDIR $HOME

ENV PATH="${HOME}/bin:${PATH}"

