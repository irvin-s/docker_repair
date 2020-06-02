FROM ruby:2.4.1  
MAINTAINER Daniel J. Pritchett <dpritchett@gmail.com>  
  
RUN apt-get update -qq  
RUN apt-get install espeak -qy  
  
ADD Gemfile /webapp/Gemfile  
ADD Gemfile.lock /webapp/Gemfile.lock  
  
WORKDIR /webapp  
RUN bundle  
  
ADD . /webapp  
  
CMD rackup -p 4567 -o '0.0.0.0'  

