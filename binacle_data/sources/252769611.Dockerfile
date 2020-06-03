FROM ruby:2.4-alpine  
  
RUN gem install papertrail  
  
CMD [ "papertrail", "--help" ]  

