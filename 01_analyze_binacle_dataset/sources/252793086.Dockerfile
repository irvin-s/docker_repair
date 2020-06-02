FROM ruby:2.3.1-alpine  
MAINTAINER Dan Jellesma  
  
ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base nodejs  
ENV RUBY_PACKAGES libxslt-dev libc6-compat libxml2-dev tzdata  
ENV DB_PACKAGES mysql-client postgresql-dev sqlite-dev  
  
RUN apk update && \  
apk upgrade && \  
apk add $BUILD_PACKAGES && \  
apk add $RUBY_PACKAGES && \  
apk add $DB_PACKAGES && \  
rm -rf /var/cache/apk/*  
  
RUN bundle config build.nokogiri --use-system-libraries  

