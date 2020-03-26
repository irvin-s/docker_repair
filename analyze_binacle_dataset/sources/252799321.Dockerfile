FROM ruby:2.4.0  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
RUN mkdir /buckbeak  
WORKDIR /buckbeak  
RUN gem install bundler rails  
ADD . /buckbeak  
RUN bundle install  
EXPOSE 3000  

