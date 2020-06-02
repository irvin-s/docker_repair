FROM ruby:2-alpine  
  
WORKDIR /usr/src/app  
COPY Gemfile /usr/src/app/  
COPY Gemfile.lock /usr/src/app/  
RUN bundle install  
  
COPY lib/ /usr/src/app/  
  
CMD ./backup.rb  

