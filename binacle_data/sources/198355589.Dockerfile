FROM ruby:2.5

ENV APP_ROOT=/usr/src/app

RUN gem install rubocop

COPY Gemfile ${APP_ROOT}/
COPY Gemfile.lock ${APP_ROOT}/
RUN bundle install

COPY . ${APP_ROOT}