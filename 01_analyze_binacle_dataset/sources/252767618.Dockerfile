FROM debian:jessie  
  
MAINTAINER Michal Kurzeja accesto.com  
  
RUN apt-get update && apt-get install -y rubygems git ruby-dev build-essential  
RUN gem install capifony hipchat && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN adduser --disabled-password -q capistrano  
  
WORKDIR /data  
VOLUME /data  
USER capistrano  
CMD /usr/local/bin/cap  

