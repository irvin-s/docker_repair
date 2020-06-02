FROM ruby:2.4.3

RUN apt-get update -qq && \
  apt-get install -y \
  libxml2-dev \
  libxslt1-dev \
  mysql-client \
  nodejs \
  cmake && \
  apt-get clean && \
  gem install bundler

ENV RAILS_ENV production
ENV APP_HOME /opt/tvarkau-vilniu
ENV MYSQL_HOST mysql
ENV MYSQL_PORT 3306

WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

EXPOSE 3000

ADD . $APP_HOME

CMD ./wait-for-it.sh $MYSQL_HOST:$MYSQL_PORT -t 60 -- ./docker-entrypoint.sh
