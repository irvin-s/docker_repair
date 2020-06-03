FROM ruby:2.5.1-slim

RUN apt-get update && apt-get install -qq -y libpq-dev nodejs build-essential git --fix-missing --no-install-recommends

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV APP_HOME /rms_rails_app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD . $APP_HOME

CMD bundle exec rails s
