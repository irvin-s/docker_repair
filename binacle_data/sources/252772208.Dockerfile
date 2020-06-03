FROM ubuntu:16.04  
  
RUN true \  
&& apt-get -qq update \  
&& apt-get -qq install -y --no-install-recommends \  
build-essential \  
cmake \  
doxygen \  
graphviz \  
&& rm -rf /var/lib/apt/lists/*  

