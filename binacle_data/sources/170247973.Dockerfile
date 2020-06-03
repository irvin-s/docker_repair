# Nature setup
FROM ubuntu:14.04

MAINTAINER IPython Project <ipython-dev@scipy.org>

ENV DEBIAN_FRONTEND noninteractive

# Not essential, but wise to set the lang
# Note: Users with other languages should set this in their derivative image
RUN apt-get update && apt-get install -y language-pack-en
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Python binary dependencies, developer tools
RUN apt-get update && apt-get install -y -q \
    build-essential \
    make \
    gcc \
    zlib1g-dev \
    git \
    python \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip \
    python-sphinx \
    python3-sphinx \
    libzmq3-dev \
    sqlite3 \
    libsqlite3-dev \
    pandoc \
    libcurl4-openssl-dev \
    nodejs \
    nodejs-legacy \
    npm

## IPYTHON INSTALLATION
# Using commit 3ccc8dfdd48ebdc1bb66a7733cc35d0eccc9bc7d

# In order to build from source, need less
RUN npm install -g less

RUN pip3 install invoke fabric

RUN mkdir -p /srv/
WORKDIR /srv/
RUN git clone https://github.com/ipython/ipython.git
WORKDIR /srv/ipython/
RUN chmod -R +rX /srv/ipython
RUN git checkout 3ccc8dfdd48ebdc1bb66a7733cc35d0eccc9bc7d
RUN git-hooks/post-checkout

RUN pip3 install -e .[all]

RUN python3 -m IPython kernelspec install-self --system

WORKDIR /tmp/
RUN iptest3

RUN alias pip=pip3
RUN alias python=python3

## PACKAGE INSTALLATION
WORKDIR /tmp/

ADD build_nature_stack.sh /tmp/build_nature_stack.sh

RUN bash /tmp/build_nature_stack.sh
RUN python3 -c "import matplotlib, scipy, numpy, pandas, sklearn, seaborn, IPython"
RUN pip3 install scikit-image

WORKDIR /srv/ipython/
