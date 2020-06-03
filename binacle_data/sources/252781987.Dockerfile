FROM kibana:5  
  
MAINTAINER Ilya Mochalov <chrootsu@gmail.com>  
  
RUN apt-get update && apt-get install -qy paxctl \  
&& paxctl -cm /usr/share/kibana/node/bin/node \  
&& rm -rf /var/lib/apt/lists/*  

