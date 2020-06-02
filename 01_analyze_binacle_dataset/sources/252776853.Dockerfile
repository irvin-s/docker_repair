FROM ruby:2.3  
RUN mkdir /grades-ms  
WORKDIR /grades-ms  
  
ADD Gemfile /grades-ms/Gemfile  
ADD Gemfile.lock /grades-ms/Gemfile.lock  
  
RUN bundle install  
ADD . /grades-ms  
  
EXPOSE 4002  
##  

