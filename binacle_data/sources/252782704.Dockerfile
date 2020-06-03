FROM debian:wheezy  
MAINTAINER Clifton King <cliftonk@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get install -y \  
wget=1.13.4-3+deb7u2 \  
sudo=1.8.5p2-1+nmu1 \  
&& rm -rf /var/lib/apt/lists/* \  
&& apt-get clean  

