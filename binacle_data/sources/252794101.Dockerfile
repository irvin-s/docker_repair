FROM ubuntu:14.04  
MAINTAINER Darren darren@cauthon.com  
  
# Set the lang to US, utf8  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
# Install base package  
RUN apt-get update  
RUN apt-get install -y wget git build-essential  
  
# Install Erlang  
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb  
RUN dpkg -i erlang-solutions_1.0_all.deb  
RUN apt-get update  
RUN apt-get install -y erlang  

