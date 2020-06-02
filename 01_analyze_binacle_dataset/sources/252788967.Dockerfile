FROM ruby:2.3.1  
RUN apt-get update && apt-get install -y mysql-client  
RUN mkdir /backup  
WORKDIR /backup  
ADD Gemfile /backup/Gemfile  
RUN bundle install  

