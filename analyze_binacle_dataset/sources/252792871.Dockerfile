FROM fluent/fluentd:latest  
MAINTAINER Kwok-kuen Cheung <me@cheungpat.com>  
RUN \  
apk add \--update \--no-cache build-base ruby-dev && \  
gem install fluent-plugin-s3 && \  
apk del build-base ruby-dev  

