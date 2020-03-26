FROM ruby:2.3  
RUN mkdir /sa_grades_ms  
WORKDIR /sa_grades_ms  
  
ADD Gemfile /sa_grades_ms/Gemfile  
ADD Gemfile.lock /sa_grades_ms/Gemfile.lock  
  
RUN bundle install  
ADD . /sa_grades_ms  
  
EXPOSE 4002

