FROM debian:jessie  
  
MAINTAINER Sylvain Ageneau <ageneau@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -y  
RUN apt-get install --no-install-recommends -y build-essential \  
automake autoconf libtool libtool-bin \  
bash-completion \  
libncurses5-dev zlib1g-dev \  
emacs24-nox less git wget curl  
  
RUN apt-get clean && apt-get autoclean  

