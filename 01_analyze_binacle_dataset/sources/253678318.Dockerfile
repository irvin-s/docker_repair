
# Copyright 2016(c) The Ontario Institute for Cancer Research. All rights reserved.

FROM ubuntu:16.04
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential libssl-dev && \
  apt-get install -y curl git man vim wget


# NODE & NPM
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
RUN source ~/.nvm/nvm.sh && nvm install 6.10.1 && npm install -g npm && npm install -g typescript

RUN mkdir -p /srv
ADD . /srv/invoice-api

# Build JS
WORKDIR /srv/invoice-api
RUN source ~/.nvm/nvm.sh && npm install && tsc -p .

# SET FILE PERMISSIONS
RUN chmod +x /srv/invoice-api/run.sh

# RUN INVOICE API
CMD ["/srv/invoice-api/run.sh"]