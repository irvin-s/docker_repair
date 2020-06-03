FROM debian:wheezy
MAINTAINER John E. Vincent

VOLUME /pkg
RUN apt-get update && apt-get install -y \
    git \
    curl \
    autoconf \
    binutils-doc \
    bison \
    flex \
    gettext \
    ncurses-dev \
    rsync \
    libyaml-dev \
    ccache \
    devscripts \
    dpkg-dev \
    fakeroot \
    build-essential \
    ruby1.9.1-full \
    libssl-dev \
    libreadline-dev \
    libxslt1-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    zlib1g-dev \
    libexpat1-dev \
    libicu-dev \
    unzip \
    m4 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git config --global user.email "packager@myco" && \
    git config --global user.name "Omnibus Packager"

RUN gem install bundler --no-ri --no-rdoc
