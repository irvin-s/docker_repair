FROM ruby:2.3-alpine  
  
RUN gem install --no-ri --no-rdoc pry  
  
ENTRYPOINT ["pry"]  

