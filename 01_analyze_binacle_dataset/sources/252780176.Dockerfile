FROM fedora:latest  
LABEL maintainer "dtc.harries@gmail.com"  
  
RUN dnf update -y --setopt=deltarpm=false \  
&& dnf install --setopt=deltarpm=false -y \  
gcc gcc-c++ gcc-gfortran binutils make \  
&& dnf clean all  

