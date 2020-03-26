# see: https://docs.docker.com/compose/rails/
# see: http://totem3.hatenablog.jp/entry/2017/08/13/133954

# see: https://hub.docker.com/_/ruby/
FROM ruby:2.5.0
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-utils tree vim less
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs

ENV APP_HOME /app
ENV PATH $APP_HOME/bin:$PATH

RUN gem install bundler

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
