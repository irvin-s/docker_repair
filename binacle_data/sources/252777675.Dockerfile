FROM ubuntu:16.04  
RUN apt-get update && apt-get install --assume-yes \  
linux-headers-generic \  
curl \  
git \  
build-essential \  
g++-5 \  
gcc \  
cmake \  
clang-5.0 \  
binutils-dev \  
libcurl4-openssl-dev \  
libelf-dev \  
libdw-dev  
  
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y  
  
ADD . /grin  
WORKDIR /grin  
  
RUN . ~/.cargo/env && cargo build  
  
RUN echo "hello"  

