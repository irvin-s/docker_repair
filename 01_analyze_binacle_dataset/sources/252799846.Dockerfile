FROM ruby:2.3-alpine  
  
RUN gem install kontena-cli  
  
ENTRYPOINT ["/usr/local/bundle/bin/kontena"]  

