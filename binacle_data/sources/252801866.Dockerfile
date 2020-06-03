FROM debian:latest  
MAINTAINER Xavier Trochu <xavier.trochu@edpsciences.org>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -q -y  
RUN apt-get dist-upgrade --no-install-recommends -q -y  
RUN apt-get install --no-install-recommends -q -y ghostscript  
RUN apt-get install --no-install-recommends -q -y texlive-full  
  

