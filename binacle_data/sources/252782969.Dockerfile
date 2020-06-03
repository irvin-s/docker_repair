FROM ruby:2.3  
RUN mkdir /sam_inbox_ms  
WORKDIR /sam_inbox_ms  
  
ADD Gemfile /sam_inbox_ms/Gemfile  
ADD Gemfile.lock /sam_inbox_ms/Gemfile.lock  
  
RUN bundle install  
ADD . /sam_inbox_ms  

