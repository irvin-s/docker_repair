FROM ruby:2.3.1  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
RUN mkdir /Update  
WORKDIR /Update  
ADD Gemfile /Update/Gemfile  
ADD Gemfile.lock /Update/Gemfile.lock  
RUN bundle install  
ADD . /Update  

