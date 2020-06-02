FROM ruby:2.3  
RUN mkdir /backend  
WORKDIR /backend  
  
ADD Gemfile /backend/Gemfile  
ADD Gemfile.lock /backend/Gemfile.lock  
  
RUN bundle install  
ADD . /backend  

