FROM ubuntu:trusty

RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev libgdbm-dev libreadline-dev libncurses5-dev libffi-dev curl

RUN curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.1.tar.gz | tar xz \
    && cd ruby-* && ./configure --disable-install-rdoc && make -j 4 && make install

RUN curl -L --progress http://www.udp.jp/software/nvxs-1.0.2.tar.gz | tar xz \
    && cd nvxs-* && ./configure && make && make install

RUN curl -L --progress http://www.udp.jp/software/AnimeFace-Ruby.tar.gz | tar xz
ADD animeface.patch ./AnimeFace-Ruby/
RUN cd AnimeFace-Ruby && patch -u animeface.c --ignore-whitespace < animeface.patch \
    && ruby extconf.rb && make && make install

RUN apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev

ADD Gemfile /app
RUN gem install bundler && bundle install -j 4

ADD . /app
CMD ruby main.rb
