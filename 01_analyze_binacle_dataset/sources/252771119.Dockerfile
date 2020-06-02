FROM ruby:2.4.1-alpine  
  
MAINTAINER Aishwarya Sutreja <ahs01077@gmail.com>  
  
RUN apk --update add docker sudo && \  
apk add --update &&\  
apk add alpine-sdk && \  
rm -rf /var/cache/apk* && \  
gem install --no-rdoc --no-ri \  
test-kitchen:1.10.2 \  
kitchen-docker:2.6.0 \  
kitchen-ec2:1.0.0 \  
kitchen-ansible:0.45.4 \  
inspec \  
kitchen-inspec  
  
ENV LANG en_US.UTF-8  
  
WORKDIR /kitchen  
  

