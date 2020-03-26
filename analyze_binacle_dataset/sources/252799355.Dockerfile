FROM ruby:2.3  
RUN mkdir /backendAds  
WORKDIR /backendAds  
  
ADD Gemfile /backendAds/Gemfile  
ADD Gemfile.lock /backendAds/Gemfile.lock  
  
RUN bundle install  
  
ADD . /backendAds  

