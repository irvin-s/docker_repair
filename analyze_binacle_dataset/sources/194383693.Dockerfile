FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get -y install \
    build-essential \
    curl \
    git-core \
    libcurl4-openssl-dev \
    libreadline-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libyaml-dev \
    zlib1g-dev && \
    curl -O http://ftp.ruby-lang.org/pub/ruby/2.6/ruby-2.6.2.tar.gz && \
    tar -zxvf ruby-2.6.2.tar.gz && \
    cd ruby-2.6.2 && \
    ./configure --disable-install-doc && \
    make && \
    make install && \
    cd .. && \
    rm -r ruby-2.6.2 ruby-2.6.2.tar.gz && \
    echo 'gem: --no-document' > /usr/local/etc/gemrc

# Install Bundler for each version of ruby
RUN \
  echo 'gem: --no-rdoc --no-ri' >> /.gemrc && \
  gem install bundler

# install sqlite3
RUN apt-get install -y sqlite3 libsqlite3-dev

RUN apt-get install -y libmysqld-dev libpq-dev

# Install Node.js and npm
RUN \
  apt-get update && \
  apt-get install -y nodejs
