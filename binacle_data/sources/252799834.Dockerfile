FROM ruby:2.1.6  
MAINTAINER Maarten Trompper <m.f.a.trompper@uva.nl>  
  
# throw errors if Gemfile has been modified since Gemfile.lock  
RUN bundle config --global frozen 1  
  
RUN mkdir -p /usr/src/app  
ADD . /usr/src/app  
WORKDIR /usr/src/app  
  
RUN bundle install  
  
CMD ["ruby", "./update_couch_db.rb"]  

