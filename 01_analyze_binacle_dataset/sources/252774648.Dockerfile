FROM ruby:2-alpine  
RUN gem install halunke && \  
adduser -D -u 10000 halunke  
USER halunke  
ENTRYPOINT ["/usr/local/bundle/bin/halunke"]  

