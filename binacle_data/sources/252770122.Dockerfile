FROM ruby:2.3.1-alpine  
  
# Copy resource scripts  
ADD assets/ /opt/resource/  
RUN chmod +x /opt/resource/*  
  
# Install native extension dependencies  
RUN apk update  
RUN apk add build-base  
  
# Install Gems  
RUN gem install bundle --no-rdoc --no-ri  
ADD Gemfile /opt/resource/  
WORKDIR /opt/resource  
RUN bundle install --without development test  

