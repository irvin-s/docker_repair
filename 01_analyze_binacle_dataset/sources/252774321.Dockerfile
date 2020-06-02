FROM ruby:2.3.1  
RUN apt-get update -qq && apt-get install -y build-essential  
RUN mkdir /application  
WORKDIR /application  
ADD Gemfile /application/Gemfile  
ADD Gemfile.lock /application/Gemfile.lock  
RUN bundle install  
ADD . /application  

