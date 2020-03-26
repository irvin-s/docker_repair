FROM ubuntu:16.04  
  
RUN apt-get update \  
&& apt-get install -y gnustep-base-runtime \  
&& rm -rf /var/lib/apt/lists/*  

