# Copyright (C) 2019 Google Inc.
# Licensed under http://www.apache.org/licenses/LICENSE-2.0 <see LICENSE file>

FROM phusion/baseimage

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' \
  && apt-get update \
  && apt-get install -y \
    curl \
    fabric \
    git-core \
    google-chrome-stable \
    graphviz \
    libfontconfig \
    make \
    mysql-client \
    nodejs \
    python-imaging \
    python-mysqldb \
    python-pip \
    python-pycurl \
    python-virtualenv \
    unzip \
    vim \
    wget \
    zip \
    pv \
  && rm -rf /var/lib/apt/lists/*

COPY ./provision/docker/my.cnf /root/.my.cnf
COPY ./provision/docker/vagrant.bashrc /root/.bashrc
COPY ./git_hooks/post-checkout /home/vagrant/.git/hooks/post-checkout
COPY ./git_hooks/post-merge /home/vagrant/.git/hooks/post-merge
WORKDIR /vagrant

# Javascript dependencies
COPY ./package.json /vagrant-dev/
COPY ./package-lock.json /vagrant-dev/
RUN cd /vagrant-dev \
  && npm install --unsafe-perm

# Python packages
COPY ./Makefile /vagrant/
COPY ./src/requirements*.txt /vagrant/src/
COPY ./bin/init_env ./bin/setup_linked_packages.py /vagrant/bin/
COPY ./extras /vagrant/extras
RUN make setup_dev DEV_PREFIX=/vagrant-dev \
  && make appengine_sdk DEV_PREFIX=/vagrant-dev \
  && make appengine_packages DEV_PREFIX=/vagrant-dev \
  && rm /vagrant-dev/opt/google-cloud-sdk-154.0.1-linux-x86_64.tar.gz

CMD bash -c 'tail -f bin/init_env'
