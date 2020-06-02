FROM ubuntu:12.04
MAINTAINER sabalah21@gmail.com

# Configuring locales
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-reconfigure locales && \
      locale-gen en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    python-software-properties

RUN add-apt-repository ppa:cartodb/postgresql-9.3 && \
    add-apt-repository ppa:cartodb/gis && \
    add-apt-repository ppa:cartodb/redis && \
    add-apt-repository ppa:cartodb/nodejs-010

RUN apt-get update && \
    apt-get install -y \
    autoconf \
    automake \
    build-essential \
    bison \
    checkinstall \
    ca-certificates \
    git-core \
    git \
    imagemagick \
    libjson0 \
    libtool \
    libreadline6 \
    libyaml-dev \
    libsqlite3-dev \
    libxml2-dev \
    libxslt-dev \
    libssl-dev \
    libpq-dev \
    libffi-dev \
    libgdbm-dev \
    libreadline6-dev \
    libcairo2-dev \
    libjpeg8-dev \
    libpango1.0-dev \
    libgif-dev \
    libgmp-dev \
    libicu-dev \
    ncurses-dev \
    nodejs \
    openssl \
    postgresql-client \
    pgtune \
    pkg-config \
    python-simplejson \
    python2.7-dev \
    python-setuptools \
    python-argparse \
    python-chardet \
    python-gdal \
    redis-server \
    syslinux \
    varnish \
    vim \
    unp \
    unzip \
    wget \
    zlib1g \
    zlib1g-dev \
    subversion \
    zip

# Install cartodb requested npm version
RUN npm install -g npm@2.14.16
RUN npm install -g forever

# GIS dependencies
RUN apt-get install -y proj proj-bin proj-data libproj-dev
RUN apt-get install -y libjson0 libjson0-dev python-simplejson
RUN apt-get install -y libgeos-c1v5 libgeos-dev
RUN apt-get install -y gdal-bin libgdal1-dev libgdal-dev
RUN apt-get install -y gdal2.1-static-bin
 
# Install Ruby
RUN cd /tmp && \
    wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz && \
    tar -xzvf ruby-install-0.5.0.tar.gz && \
    cd ruby-install-0.5.0/ && \
    make install && \
    ruby-install ruby 2.2.3

# Set ruby && gdal enviorment variables
ENV PATH $PATH:/opt/rubies/ruby-2.2.3/bin
ENV CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH:/usr/include/gdal
ENV C_INCLUDE_PATH $C_INCLUDE_PATH:/usr/include/gdal
ENV PATH $PATH:/usr/include/gdal
ENV GDAL_DATA=/usr/share/gdal/2.1

# Install SQL API
RUN git clone git://github.com/CartoDB/CartoDB-SQL-API.git && \
    cd CartoDB-SQL-API && \
    git checkout master && \
    ./configure && \
    npm install && \
    mv config/environments/development.js.example config/environments/development.js && \
    mv config/environments/production.js.example config/environments/production.js && \
    mv config/environments/staging.js.example config/environments/staging.js && \
    mv config/environments/test.js.example config/environments/test.js 

# Install Windshaft
RUN git clone git://github.com/CartoDB/Windshaft-cartodb.git && \
    cd Windshaft-cartodb && \
    git checkout master && \
    ./configure && \
    npm install && \
    mkdir logs && \
    cp config/environments/development.js.example config/environments/development.js && \
    cp config/environments/production.js.example config/environments/production.js && \
    cp config/environments/staging.js.example config/environments/staging.js && \
    cp config/environments/test.js.example config/environments/test.js 

# Install gems
RUN gem install bundler
RUN gem install compass

# Install pip
RUN wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py && \
    python /tmp/get-pip.py

# Install Carto App
RUN git clone --recursive https://github.com/CartoDB/cartodb20.git
RUN cd /cartodb20 && git checkout master
RUN cd /cartodb20 && RAILS_ENV=development bundle install
RUN cd /cartodb20 && npm install
RUN cd /cartodb20 && pip install --no-use-wheel -r python_requirements.txt

ENV PATH $PATH:/cartodb20/node_modules/grunt-cli/bin
 
RUN cd /cartodb20 && \
    bundle install && \
    bundle exec grunt --environment development && \
    cp config/app_config.yml.sample config/app_config.yml && \
    cp config/database.yml.sample config/database.yml && \
    mkdir log

CMD ["/bin/bash"]
