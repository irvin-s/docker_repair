FROM ruby:2.2.0  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev  
COPY . ~/movies-info  
WORKDIR ~/movies-info  
ADD Gemfile ~/movies-info/Gemfile  
ADD Gemfile.lock ~/movies-info/Gemfile.lock  
RUN bundle install  

