FROM ruby:alpine  
  
RUN apk --update add git openssh && \  
rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  
  
RUN mkdir /usr/src/app  
WORKDIR /usr/src/app  
  
ADD Gemfile /usr/src/app/Gemfile  
ADD Gemfile.lock /usr/src/app/Gemfile.lock  
RUN bundle install --deployment --without development test  
ADD . /usr/src/app  

