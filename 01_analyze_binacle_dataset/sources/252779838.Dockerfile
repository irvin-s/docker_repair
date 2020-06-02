FROM ruby:2.1  
MAINTAINER Conjur, Inc  
  
WORKDIR /src  
ADD Gemfile Gemfile.lock ./  
RUN bundle install --without development  
  
ADD . ./  
  
ENTRYPOINT ["bundle", "exec", "bin/docker-cleanup"]  

