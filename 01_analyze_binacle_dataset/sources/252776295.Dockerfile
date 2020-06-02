FROM ubuntu:14.04  
  
RUN apt-get update && apt-get install -y \  
libpng12-dev libfreetype6-dev libxt6 libsm6 libice6 \  
libblas-dev liblapack-dev gfortran build-essential xorg  
  
RUN useradd -ms /bin/bash block  
  
ENV PATH="/usr/local/MATLAB/from-host/bin:${PATH}"  
  
USER block  

