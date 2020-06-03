FROM debian:wheezy  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
  
RUN apt-get update && \  
apt-get install -y \  
figlet && \  
rm -rf /var/lib/apt/lists/*

