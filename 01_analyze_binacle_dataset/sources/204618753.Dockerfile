FROM ubuntu:precise

RUN apt-get update -y \
  && apt-get -y install git-core software-properties-common python-software-properties --no-install-recommends \
  && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
  && add-apt-repository ppa:openjdk-r/ppa \
  && apt-get update -y \
  && apt-get install -y automake autoconf libtool build-essential gcc-4.9 g++-4.9 \
                        zlibc zlib1g zlib1g-dev \
                        ruby1.9.1 ruby1.9.1-dev python-dev python-boto \
                        maven \
                        libsasl2-dev libsasl2-modules \
                        libcurl4-openssl-dev libapr1-dev libsvn-dev --no-install-recommends \
  && apt-get install -y openjdk-8-jdk --no-install-recommends \
  && ln -sf /usr/bin/gcc-4.9 /usr/bin/gcc \
  && ln -sf /usr/bin/g++-4.9 /usr/bin/g++ \
  && gem install fpm --no-ri --no-rdoc

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64