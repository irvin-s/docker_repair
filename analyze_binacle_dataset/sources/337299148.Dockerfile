FROM debian:jessie
MAINTAINER Lukas Matt <lukas@zauberstuhl.de>

ENV DEBIAN_FRONTEND noninteractive
ENV RAILS_ENV production
ENV DISABLE_DATABASE_ENVIRONMENT_CHECK 1

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install libreadline-dev cmake build-essential libssl-dev libcurl4-openssl-dev libxml2-dev libxslt-dev imagemagick ghostscript curl libmagickwand-dev git libpq-dev redis-server nodejs postgresql-client

RUN mkdir /tmp/ruby && cd /tmp/ruby \
  && curl -L --progress http://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.2.tar.gz | tar xz \
  && cd ruby-2.4.2 \
  && ./configure --disable-install-rdoc \
  && make -j2 \
  && make install

RUN gem install bundler

RUN git clone --depth 1 https://github.com/diaspora/diaspora.git -b master

WORKDIR /diaspora

RUN cp config/database.yml.example config/database.yml \
  && cp config/diaspora.yml.example config/diaspora.yml

RUN bundle install --with postgresql

RUN sed -i "s/#rails_environment:.*/rails_environment: 'production'/" config/diaspora.yml
RUN sed -i "s/#url:/url:/" config/diaspora.yml
RUN sed -i "0,/#certificate_authorities/ s/#certificate_authorities:/certificate_authorities:/" config/diaspora.yml
RUN sed -i "s/#require_ssl:.*/require_ssl: false/" config/diaspora.yml
RUN sed -i "s/#serve:.*/serve: true/" config/diaspora.yml

RUN bundle exec rails assets:precompile

RUN curl -LO http://download.redis.io/redis-stable.tar.gz
RUN tar -xvzf redis-stable.tar.gz
RUN cd redis-stable && make
RUN cd redis-stable && make install
RUN rm -rf redis-stable

COPY schema.sql /diaspora/schema.sql
COPY start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
