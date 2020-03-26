FROM node:8

RUN apt-get update \
  && apt-get -y install apt-utils \
          build-essential \
          git-core \
          curl libssl-dev \
          libreadline-dev \
          zlib1g zlib1g-dev \
          libcurl4-openssl-dev \
          libxslt-dev libxml2-dev \
          locales \
          apt-transport-https \
          rsync \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# install java
RUN echo "deb [check-valid-until=no] http://archive.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/backports.list \
  && apt-get update \
  && apt-get install -t jessie-backports -y openjdk-8-jre-headless ca-certificates-java \
  && rm /etc/apt/sources.list.d/backports.list \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*

# install chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update \
  && apt-get -y install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*
ENV CHROME_BIN /usr/bin/google-chrome-stable

ENV CONTAINER_INIT /usr/local/bin/init-container
RUN echo '#!/usr/bin/env bash' > $CONTAINER_INIT ; chmod +x $CONTAINER_INIT

RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
