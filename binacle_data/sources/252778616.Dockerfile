FROM ruby:2.3  
RUN mkdir /courses-ms  
WORKDIR /courses-ms  
  
ADD Gemfile /courses-ms/Gemfile  
ADD Gemfile.lock /courses-ms/Gemfile.lock  
  
RUN bundle install  
ADD . /courses-ms  
EXPOSE 4001  

