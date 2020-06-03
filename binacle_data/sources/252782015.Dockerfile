FROM ubuntu:14.04  
MAINTAINER Chuanwen Chen "chuanwen@gmail.com"  
  
RUN apt-get update && apt-get install -y cowsay fortunes \  
&& rm -rf /var/lib/apt/lists/*  
  
CMD /usr/games/fortune -a | /usr/games/cowsay  

