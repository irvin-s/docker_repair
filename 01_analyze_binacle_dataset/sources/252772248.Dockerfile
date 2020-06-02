FROM ruby:2.4-alpine  
LABEL Name=sample-rails-app Version=0.0.1  
  
RUN apk update && apk add build-base nodejs sqlite-dev sqlite  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
RUN bundle install --binstubs  
  
COPY . .  
  
LABEL maintainer="Nick Janetakis <nick.janetakis@gmail.com>"  
  
CMD puma -C config/puma.rb

