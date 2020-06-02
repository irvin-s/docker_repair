FROM ruby:2.3-alpine  
  
MAINTAINER Andre Kosak "andrekosak@icloud.com"  
RUN echo 'gem: --no-document' >> /etc/gemrc \  
&& apk add --no-cache \  
curl \  
git \  
&& gem install dpl  
  
RUN mkdir -p /opt/project  
WORKDIR /opt/project

