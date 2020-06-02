FROM ruby:alpine  
RUN gem install ultrahook  
ENTRYPOINT /usr/local/bundle/bin/ultrahook  

