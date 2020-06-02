FROM ubuntu:xenial

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    git \
    libapr1-dev libsvn-dev \
    libcurl4-openssl-dev \
    libsasl2-dev \
    libsasl2-modules \
    libtool \
    maven \
    openjdk-8-jdk \
    python-boto \
    python-dev \
    python-software-properties \
    software-properties-common \
    ruby \
    ruby-dev \
    zlib1g \
    zlib1g-dev \
    zlibc \
  && gem install fpm --no-ri --no-rdoc

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
