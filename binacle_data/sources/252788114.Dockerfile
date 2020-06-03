FROM createkio/docker-ruby:2.3.3-slim  
  
MAINTAINER CreatekIO  
  
WORKDIR /app  
  
COPY Gemfile Gemfile.lock ./  
RUN bundle install --jobs 20 --retry 5 && \  
rm -rf /app/*  
  

