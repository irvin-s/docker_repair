FROM elasticsearch:5  
  
MAINTAINER Ilya Mochalov <chrootsu@gmail.com>  
  
RUN apt-get update && apt-get install -qy paxctl \  
&& paxctl -cm /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java \  
&& rm -rf /var/lib/apt/lists/*  

