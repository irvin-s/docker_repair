FROM ruby:2.1.7

ENV APP_HOME /app
RUN mkdir $APP_HOME

RUN apt-get update && apt-get install -y openjdk-7-jre

WORKDIR /tmp 
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD supplejack_api.gemspec supplejack_api.gemspec
RUN bundle install

WORKDIR $APP_HOME

ADD . .

CMD bundle exec rspec
