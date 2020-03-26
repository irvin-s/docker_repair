# Bundler Runner  
#  
# VERSION 0.0.1  
FROM ubuntu:precise  
MAINTAINER Benjamin Cavileer, bcavileer@gmail.com  
RUN apt-get update  
RUN apt-get install -y ruby1.9.3 git build-essential  
RUN gem install bundler --no-ri --no-rdoc  
WORKDIR /app  
CMD bundle install --deployment; bundle exec $SERVICE_NAME  

