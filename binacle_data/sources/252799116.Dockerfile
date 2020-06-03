FROM debian:jessie  
  
MAINTAINER Andreas Schmidt <andreas@de-wiring.net>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -yq && \  
apt-get install -yq ruby ruby-dev make build-essential rubygems && \  
gem install rake -v '10.4.0' \--no-rdoc --no-ri && \  
gem install cucumber -v '1.3.17' \--no-rdoc --no-ri && \  
gem install docker-api -v '1.15.0' \--no-rdoc --no-ri && \  
gem install rspec -v '3.1.0' \--no-rdoc --no-ri && \  
gem install specinfra -v '2.15.0' \--no-rdoc --no-ri && \  
gem install serverspec -v '2.9.0' \--no-rdoc --no-ri && \  
apt-get purge -yq make build-essential ruby-dev && \  
rm -rf /var/lib/apt/lists/*  
  
VOLUME /spec  
WORKDIR /spec  
  

