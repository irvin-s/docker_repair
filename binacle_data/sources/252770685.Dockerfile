FROM ubuntu:xenial  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -y  
RUN apt-get install -y jq bats curl  
RUN apt-get clean  

