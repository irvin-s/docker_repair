FROM ubuntu:xenial  
  
RUN apt-get clean && apt-get update && apt-get install -y locales  
  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
  
RUN apt-get -y update && apt-get install -y shellcheck  

