FROM quay.io/netguru/baseimage:0.10.0

ENV RUBY_VERSION 2.5.1

## Install Ruby
RUN \
  apt-get update -q && \
  ruby-install --system --cleanup ruby $RUBY_VERSION && \
  gem install bundler -v '1.17.3'

## Copy Gemfile & bundle
ADD Gemfile* $APP_HOME/
RUN bundle install --jobs=8 --retry=3 --without development test --deployment

## Add rest of code
ADD . $APP_HOME/

ENV RAILS_ENV staging
ENV PUMA_WORKERS 2

RUN gem install puma

## Build react_bundle package
RUN yarn
RUN npm run build
RUN rm -rf node_modules

#### Set proper timezone
RUN \
  ln -fs /usr/share/zoneinfo/Europe/Warsaw /etc/localtime && \
  dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Link configuration files with env variables
RUN ln -s /app/config/database.yml.env /app/config/database.yml
