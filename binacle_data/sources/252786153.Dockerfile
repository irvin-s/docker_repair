FROM rikorose/gcc-cmake:gcc-7 as build  
RUN mkdir /src  
COPY . src  
WORKDIR src  
RUN mkdir build && cd build && cmake .. && make  
  
FROM ubuntu:17.10  
COPY \--from=build /src/build/src/packer/midgetpack /midgetpack  

