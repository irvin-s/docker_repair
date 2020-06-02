FROM debian:7  
MAINTAINER Bilge <bilge@scriptfusion.com>  
  
# Install dependencies.  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive\  
apt-get install -y ruby-full make git  
  
# Install Travis CLI.  
RUN gem install --no-rdoc --no-ri travis  

