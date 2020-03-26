FROM alpine:3.2  
MAINTAINER Jeff Nickoloff <jnickoloff@shutterfly.com>  
  
# Update and install base packages  
RUN apk update && apk upgrade && apk add curl wget bash  
  
# Install ruby and ruby-bundler  
RUN apk add ruby ruby-bundler ruby-dev  
  
# Clean APK cache  
RUN rm -rf /var/cache/apk/*  
  
RUN gem install mustache  

