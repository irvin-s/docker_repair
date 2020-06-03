FROM ubuntu  
#:precise  
MAINTAINER pgolm "golm.peter@gmail.com"  
# Config  
#ENV INSTALL_RUBY_VERSION 2.1.0  
# apt-get deps  
RUN apt-get update -y  
RUN apt-get install -y -q curl sudo wget git build-essential libicu-dev \  
lsb-release software-properties-common tklib zlib1g-dev libssl-dev \  
libreadline-gplv2-dev libxml2 libxml2-dev libxslt1-dev \  
net-tools inetutils-ping vim cowsay  
  

