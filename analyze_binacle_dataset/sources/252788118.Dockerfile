FROM ruby:2.4.0  
MAINTAINER Hassan Khalid <hassan@createk.io>  
  
ENV TERM=xterm  
  
WORKDIR /kata  
COPY Gemfile Gemfile.lock ./  
RUN bundle install --jobs 20 --retry 2  
  

