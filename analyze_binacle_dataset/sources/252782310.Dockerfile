FROM ruby:2.3.1  
ADD Gemfile* /tests/  
WORKDIR /tests  
RUN gem install bundler && bundle install  
  
ADD . /tests/  
  

