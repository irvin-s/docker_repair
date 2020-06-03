FROM debian:jessie  
  
MAINTAINER Marcel Brand <marcel.brand@achtachtel.de>  
  
# Run update and install wget  
RUN apt-get update && apt-get install -y \  
wget  
  
# Add dotdeb repository to sources.list.d  
ADD ./dotdeb.list /etc/apt/sources.list.d/  
  
# Add dotdeb repository key  
RUN wget -O- https://www.dotdeb.org/dotdeb.gpg | apt-key add -

