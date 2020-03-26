FROM ubuntu:latest  
  
MAINTAINER Damien Plenard "damien+docker@plenard.me"  
  
RUN mkdir -p /usr/src/app/build  
WORKDIR /usr/src/app/build  
COPY digitalnote /usr/src/app  
  
RUN apt-get update && apt-get install -y \  
g++ \  
cmake \  
libboost-system1.55-dev \  
libboost-filesystem1.55-dev \  
libboost-thread1.55-dev \  
libboost-date-time1.55-dev \  
libboost-chrono1.55-dev \  
libboost-regex1.55-dev \  
libboost-serialization1.55-dev \  
libboost-program-options1.55-dev \  
libboost-coroutine1.55-dev \  
libboost-context1.55-dev \  
libboost1.55-dev  
RUN cmake .. && make  
RUN apt-get remove -y \  
g++ \  
cmake \  
libboost-system1.55-dev \  
libboost-filesystem1.55-dev \  
libboost-thread1.55-dev \  
libboost-date-time1.55-dev \  
libboost-chrono1.55-dev \  
libboost-regex1.55-dev \  
libboost-serialization1.55-dev \  
libboost-program-options1.55-dev \  
libboost-coroutine1.55-dev \  
libboost-context1.55-dev \  
libboost1.55-dev  
  
WORKDIR /usr/src/app/build/src  

