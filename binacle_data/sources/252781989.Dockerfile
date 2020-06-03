FROM mongo:3.2  
  
MAINTAINER Ilya Mochalov <chrootsu@gmail.com>  
  
RUN apt-get update && apt-get install -qy paxctl && paxctl -Cm /usr/bin/mongo  

