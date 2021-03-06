FROM debian:jessie

MAINTAINER Ric Lister <rlister@gmail.com>

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    build-essential \
    zlib1g-dev \
    libssl-dev \
    libreadline6-dev \
    libyaml-dev

ENV RUBY_MAJOR_VERSION 2.1
ENV RUBY_MINOR_VERSION 2.1.8

ADD http://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR_VERSION}/ruby-${RUBY_MINOR_VERSION}.tar.gz /tmp/

RUN tar -zxf /tmp/ruby-${RUBY_MINOR_VERSION}.tar.gz && \
    (cd ruby-${RUBY_MINOR_VERSION} && ./configure --disable-install-doc && make install) && \
    rm -rf /tmp/ruby-${RUBY_MINOR_VERSION}.tar.gz && rm -rf ruby-${RUBY_MINOR_VERSION}

RUN gem install bundler --no-rdoc --no-ri