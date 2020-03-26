FROM ruby:alpine  
  
COPY Gemfile /Gemfile  
  
RUN mkdir -p /opt/resource && \  
bundle install  
  
COPY check /opt/resource/check  
COPY in /opt/resource/in  
COPY out /opt/resource/out  

