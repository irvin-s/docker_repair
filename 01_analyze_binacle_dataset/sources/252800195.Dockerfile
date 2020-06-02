FROM ruby:2.4.2  
MAINTAINER Dirk Siemers <dirk@sovido.de>  
  
RUN apt-get update -qq && apt-get install -y build-essential  
  
# for nokogiri  
RUN apt-get install -y libxml2-dev libxslt1-dev  
  
# for capybara-webkit  
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb  
  
# for a JS runtime  
RUN apt-get install -y nodejs  
  
RUN mkdir /usr/app  
WORKDIR /usr/app  

