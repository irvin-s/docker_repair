FROM ubuntu:latest  
  
RUN apt-get update \  
&& apt-get install -y clang \  
make \  
cmake \  
git \  
build-essential \  
ninja-build \  
&& rm -rf /var/lib/apt/lists/*

