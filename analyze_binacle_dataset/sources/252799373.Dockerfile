FROM ruby:2.3.1  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev  
RUN mkdir /blog  
WORKDIR /blog  
ADD Gemfile /blog/Gemfile  
ADD Gemfile.lock /blog/Gemfile.lock  
RUN bundle install  
ADD . /blog  

