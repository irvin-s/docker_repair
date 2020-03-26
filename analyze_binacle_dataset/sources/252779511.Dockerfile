FROM ruby:alpine  
MAINTAINER caktux  
RUN apk add --no-cache build-base && \  
gem install travis && \  
gem install travis-lint && \  
apk del build-base  
RUN apk add --no-cache git  
RUN mkdir project  
WORKDIR project  
VOLUME ["/project"]  
ENTRYPOINT ["travis"]  

