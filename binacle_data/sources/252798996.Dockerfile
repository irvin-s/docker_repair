FROM ubuntu:14.04  
  
RUN \  
apt-get update \  
&& apt-get -yyq --force-yes install curl wget \  
&& rm -rf /var/lib/apt/*  

