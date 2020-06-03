FROM ubuntu:16.04  
  
RUN apt-get update \  
&& apt-get install -y sudo curl \  
&& sudo rm -rf /var/lib/apt/lists/*  

