FROM ruby:2.3.1
MAINTAINER Vasily Kolesnikov <re.vkolesnikov@gmail.com>

RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs

ENV APP_HOME /emilito
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
    BUNDLE_JOBS=4 \
    BUNDLE_PATH=/bundle
ADD Gemfile* $APP_HOME/
RUN bundle install
