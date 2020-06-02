FROM ruby:2.4.2-alpine  
  
RUN apk add --update alpine-sdk nodejs  
RUN gem install middleman  

