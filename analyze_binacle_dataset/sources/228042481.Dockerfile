FROM debian:jessie

RUN apt-get clean &&\
    apt-get -y update &&\
    apt-get clean &&\
    apt-get -y dist-upgrade &&\
    apt-get clean &&\
    apt-get install -y build-essential \
    libncurses5-dev \
    openssl \
    monit \
    libssl-dev \
    wget \
    git \
    postgresql-client \
    debconf \
    locales

# Set the locale
ENV DEBIAN_FRONTEND noninteractive
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV MIX_ENV prod

COPY build/rebar /usr/local/bin/.
COPY build/install_erlang.sh .
RUN ./install_erlang.sh

RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp

RUN mix deps.get
RUN MIX_ENV=prod mix compile 
RUN mix release
COPY build/credo.monit.conf /etc/monit/conf.d/credo.conf
