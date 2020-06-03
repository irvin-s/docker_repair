FROM ubuntu:14.04  
  
MAINTAINER Anthony Lapenna <lapenna.anthony@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBCONF_NONINTERACTIVE_SEEN true  
  
RUN apt-get update && apt-get install -y wget  
  
RUN wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb \  
&& dpkg -i puppetlabs-release-trusty.deb \  
&& apt-get update \  
&& apt-get install -y puppet \  
&& rm -rf puppetlabs-release-trusty.deb  

