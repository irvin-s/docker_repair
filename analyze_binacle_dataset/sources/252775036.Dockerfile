FROM ruby:2.3  
RUN mkdir /sa_api_gateway  
WORKDIR /sa_api_gateway  
ADD Gemfile /sa_api_gateway/Gemfile  
ADD Gemfile.lock /sa_api_gateway/Gemfile.lock  
RUN bundle install  
ADD . /sa_api_gateway  

