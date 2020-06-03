FROM ubuntu:16.04  
MAINTAINER tilldettmering@gmail.com  
  
RUN apt-get update &&\  
apt-get install --no-install-recommends -y ruby-dev rubygems git curl &&\  
apt-get clean -y && rm -rf /var/lib/apt/lists/* &&\  
gem install dpl  

