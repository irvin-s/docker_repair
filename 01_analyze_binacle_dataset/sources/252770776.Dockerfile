FROM ruby:2.4-alpine  
  
RUN apk --update add postgresql-client git bash && rm -rf /var/cache/apk/*  
  
RUN gem install schema-evolution-manager  
  
RUN mkdir /db  
WORKDIR /db  

