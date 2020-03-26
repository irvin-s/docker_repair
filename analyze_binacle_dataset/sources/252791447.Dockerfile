FROM ruby:2.3  
RUN mkdir /students-ms  
WORKDIR /students-ms  
  
ADD Gemfile /students-ms/Gemfile  
ADD Gemfile.lock /students-ms/Gemfile.lock  
  
RUN bundle install  
ADD . /students-ms  
  
EXPOSE 4000  

