FROM debian:jessie  
  
MAINTAINER Derek Slager <derekslager@gmail.com>  
  
RUN apt-get update -qq && apt-get -y install openjdk-7-jdk wget  

