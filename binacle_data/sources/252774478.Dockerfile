FROM ruby:2.3  
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs  
RUN mkdir /grades-ms  
WORKDIR /grades-ms  
COPY Gemfile /grades-ms/Gemfile  
COPY Gemfile.lock /grades-ms/Gemfile.lock  
RUN bundle install  
COPY . /grades-ms  
  
EXPOSE 4002  

