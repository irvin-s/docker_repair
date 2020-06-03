# Dockerfile for purkinje development
FROM ubuntu:16.04
MAINTAINER Bernhard Biskup <bbiskup@gmx.de>

# Install dependencies
RUN echo 'Running installation'
WORKDIR /code

ENV DEBIAN_FRONTEND noninteractive
ENV NODE_DIR=node-v6.2.0-linux-x64
ENV NODE_ARCHIVE=$NODE_DIR.tar.xz
ENV PATH=/opt/node/bin:$PATH

RUN apt-get -q -y update && apt-get install -y wget


RUN echo 1 > cache_bust.txt
# Install Google Chrome APT repository
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get -q -y update && apt-get install -y \
        dbus-x11 \
        default-jre-headless \
        firefox \
        gcc \
        git \
        google-chrome-stable \
        libyaml-dev \
        make \
        python2.7 \
        python2.7-dev \
        python3.5 \
        python3.5-dev \
        software-properties-common \
        wget \
        xvfb \
        xz-utils \
    && rm -rf /var/lib/apt/lists/*

# To avoid chrome waiting for gnome keyring
ENV DBUS_SESSION_BUS_ADDRESS /dev/null
RUN dpkg -r libfolks-eds25 gnome-keyring seahorse gcr evolution-data-server oneconf python-ubuntuone-storageprotocol ubuntu-sso-client python-ubuntu-sso-client pinentry-gnome3

# TODO remove git dependency when removing bower

# Install node.js; use most recent version to have access to latest features
WORKDIR /opt
RUN wget -q https://nodejs.org/dist/v6.2.0/$NODE_ARCHIVE && \
    tar xJf $NODE_ARCHIVE && \
    ln -s /opt/$NODE_DIR /opt/node && \
    rm $NODE_ARCHIVE
WORKDIR /code
RUN node --version
RUN npm --version

# make npm less noisy
RUN npm config set loglevel warn
RUN python2.7 --version
RUN ln -sf /usr/bin/python2.7 /usr/bin/python

# Ubuntu's python-pip throws exception with requests lib
# see https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1306991
RUN wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py

ADD package.json /code/package.json
ADD bower.json /code/bower.json
ADD .jshintrc /code/.jshintrc
ADD .bowerrc /code/.bowerrc

RUN npm install

# Set up Chrome webdriver for Protractor
RUN echo 1 > cache_bust.txt  # force layer invalidation
RUN ./node_modules/protractor/bin/webdriver-manager update --standalone

RUN npm install -g bower
RUN bower --allow-root --quiet install -F 2>&1 > bower.log

ADD requirements.txt /code/requirements.txt
ADD dev-requirements.txt /code/dev-requirements.txt

# Python
RUN pip install -q --upgrade -r dev-requirements.txt --cache-dir $HOME/.pip-cache

# Avoid Flask freezing
# watchdog not compatible with gevent
# see https://github.com/gorakhargosh/watchdog/issues/306
RUN pip uninstall -y watchdog

RUN echo "Installed Python packages:"
RUN pip freeze

ADD pytest.ini /code/pytest.ini
ADD tox.ini /code/tox.ini
ADD MANIFEST.in /code/MANIFEST.in
ADD setup.py /code/setup.py
ADD Makefile /code/Makefile
ADD purkinje /code/purkinje
ADD ./docker/purkinje*.yml /code/

ADD README.rst README.rst
ADD CHANGES.rst CHANGES.rst


RUN pip install -e .
RUN python setup.py sdist

ENV NODE_ARCHIVE ""
ENV NODE_DIR ""

ADD docker/purkinje.docker.yml purkinje.yml

ENTRYPOINT ["purkinje", "-c", "purkinje.yml"]
