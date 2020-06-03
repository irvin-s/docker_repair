FROM ruby:2.3.1  
RUN mkdir /app  
WORKDIR /app  
  
ADD Gemfile /app/Gemfile  
ADD Gemfile.lock /app/Gemfile.lock  
RUN gem update bundler  
RUN bundle install  
  
ADD . /app  
CMD bin/cli  

