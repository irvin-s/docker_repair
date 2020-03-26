FROM ruby:2.4.1-alpine  
  
MAINTAINER CreatekIO  
  
WORKDIR /takeoff  
  
RUN apk add --update --upgrade build-base curl git openssh-client  
  
COPY . ./  
  
RUN gem install bundler && bundle install --jobs 20 --retry 2  

