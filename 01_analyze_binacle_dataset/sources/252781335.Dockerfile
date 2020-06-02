FROM ruby:2.3.1  
MAINTAINER Stuart Auld <sauld@cozero.com.au>  
ENV REFRESHED_AT 2016-09-23  
  
# Monit, NodeJS & aws cli tools  
RUN \  
apt-get -y update \  
&& apt-get install -y \  
awscli \  
monit \  
nodejs \  
npm \  
# Link NodeJS  
&& ln -s /usr/bin/nodejs /usr/bin/node \  
# Update system gems  
&& gem update --system  

