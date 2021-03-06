FROM ruby:2.6-alpine

RUN apk --update add build-base openssh docker nodejs git tzdata vim --no-cache
ENV APP_HOME=/data/rails

WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/

RUN bundle install -j4

COPY ./docker/base/.vimrc /root/.vimrc
COPY ./docker/base/.ssh /root/.ssh
RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/config

COPY . $APP_HOME
VOLUME $APP_HOME
