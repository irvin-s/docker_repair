FROM ruby:2.3.0

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

ENV APP_HOME /teki
RUN mkdir $APP_HOME
RUN mkdir $APP_HOME/tmp
WORKDIR $APP_HOME

ADD . $APP_HOME

ADD Gemfile* $APP_HOME/
ADD unicorn.rb $APP_HOME/config/unicorn.rb
RUN bundle install

EXPOSE 3000
ENV RAILS_ENV=production
CMD foreman start -f Procfile
