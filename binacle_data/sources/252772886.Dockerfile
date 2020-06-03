FROM ubuntu:14.04  
MAINTAINER berretterry@gmail.com  
  
#this is the lynx install  
RUN apt-get update && apt-get install -y \  
lynx \  
\--no-install-recommends \  
&& rm -rf /var/lib/apt/lists/*  
#entrypoint for running lynx  
ENTRYPOINT ["lynx"]  
  

