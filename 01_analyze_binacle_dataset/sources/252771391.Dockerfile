# -*- mode: dockerfile -*-  
# dockerfile to build libmxnet.so on GPU  
FROM nvidia/cuda:8.0-cudnn5-devel  
  
COPY install/cpp.sh install/  
RUN install/cpp.sh  

