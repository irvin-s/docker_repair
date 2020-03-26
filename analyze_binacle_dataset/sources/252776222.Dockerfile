FROM ubuntu:14.04  
MAINTAINER Bohan Zhang <me@bohanzhang.com>  
ENV REFRESHED_AT 2015-11-21  
COPY sources.list /etc/apt/sources.list  
RUN apt-get -y update  

