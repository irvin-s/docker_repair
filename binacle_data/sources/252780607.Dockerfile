#setup from http://docs.transifex.com/integrations/github/  
FROM ruby:2.1.8  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY Gemfile /usr/src/app/  
  
# install bundled gems  
RUN bundle install  
  
COPY . /usr/src/app/  
  
# start the server  
CMD ["bundle","exec","rackup", "-p", "80"]

