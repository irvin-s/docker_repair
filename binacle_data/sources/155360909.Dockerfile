FROM ubuntu:trusty
MAINTAINER  Jessica Frazelle <github.com/jfrazelle>

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    autoconf \
    automake \
    bison \
    build-essential \
    curl \
    git-core \
    libc6-dev \
    libsqlite3-dev \
    libreadline6 \
    libreadline6-dev \
    libssl-dev \
    libtool \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    ncurses-dev \
    openssl \
    pkg-config \
    sqlite3 \
    subversion \
    wget \
    zlib1g \
    zlib1g-dev \
    --no-install-recommends

# install ruby
RUN wget http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
RUN tar xvf ruby-2.1.2.tar.gz
RUN cd ruby-2.1.2; ./configure; make; make install
RUN rm -rf ruby-2.1.2
RUN gem update --system

# install bundler
RUN gem install bundler

# add the source
COPY . /src

# install bundles
RUN cd /src; bundle install

WORKDIR /src

CMD ruby app.rb -o 0.0.0.0