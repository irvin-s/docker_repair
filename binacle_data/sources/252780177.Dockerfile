FROM ubuntu:latest  
LABEL maintainer "dtc.harries@gmail.com"  
  
RUN apt-get update -y \  
&& apt-get install -y \  
gcc g++ gfortran binutils make \  
&& apt-get clean -y \  
&& rm -rf /var/lib/apt/lists/*  

