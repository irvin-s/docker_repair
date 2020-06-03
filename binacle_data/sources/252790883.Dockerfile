FROM alpine:3.2  
MAINTAINER Angel Pena Ruiz <angel@cultureamp.com>  
  
ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base  
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler libffi-dev  
ENV JEKYLL_DEPENDENCIES libxml2-dev libxslt-dev  
  
# this is required to be able to compile  
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1  
# Update and install all of the required packages.  
# At the end, remove the apk cache  
RUN apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
apk add $RUBY_PACKAGES && \  
apk add $JEKYLL_DEPENDENCIES && \  
rm -rf /var/cache/apk/*  
  
RUN gem install bundler  
RUN mkdir -p /usr/src/myapp  
WORKDIR /usr/src/myapp  
  
COPY Gemfile /usr/src/myapp/  
COPY Gemfile.lock /usr/src/myapp/  
RUN bundle install  

