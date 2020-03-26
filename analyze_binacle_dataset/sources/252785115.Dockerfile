FROM ruby:slim  
  
#For https://github.com/bundler/bundler/issues/4576  
RUN gem install bundler  
RUN bundle config --global frozen 1  
  
#Debian has a really old nodejs, pull in the 4.x LTS  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get update && apt-get install -y git build-essential libpq-dev nodejs  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
  
RUN bundle install  
  
COPY . /usr/src/app  
  
RUN cd client && npm install && npm run build:production  
  
CMD bundle exec puma -C config/puma.rb

