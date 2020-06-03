FROM debian:jessie

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list.d/jessie-backports.list \
  && apt-get update -y \
  && apt-get -y install automake autoconf libtool build-essential \
                        zlibc zlib1g zlib1g-dev \
                        ruby ruby-dev python-dev python-boto \
                        maven \
                        libsasl2-dev libsasl2-modules \
                        libcurl4-openssl-dev libapr1-dev libsvn-dev --no-install-recommends \
  && apt-get install -y openjdk-8-jdk --no-install-recommends \
  && gem install fpm --no-ri --no-rdoc

ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64