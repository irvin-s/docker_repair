FROM microsoft/dotnet:latest  
  
RUN apt-get update  
  
RUN apt-get install -y --no-install-recommends \  
git \  
build-essential \  
libtool \  
autoconf \  
automake \  
pkg-config \  
unzip \  
libkrb5-dev \  
uuid-dev  
  
RUN mkdir /tmp/build  

