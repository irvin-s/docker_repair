FROM ubuntu:trusty  
MAINTAINER Andy Gomez <andy@andygomez.org>  
  
ENV DEBIAN_FRONTEND='noninteractive'  
RUN apt-get update  
  
RUN apt-get install -y ca-certificates wget  
  
RUN wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb  
  
RUN dpkg -i puppetlabs-release-trusty.deb  
  
RUN apt-get update  
  
RUN apt-get install puppet -y  
  
RUN echo TEST  
  
VOLUME /etc/puppet/modules  
  
VOLUME /etc/puppet/manifests  
  

