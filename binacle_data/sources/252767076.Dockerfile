#  
# cuda-base: Sets up a boilerplate Docker environment for NVIDIA CUDA.  
#  
# Base image is CUDA + cuDNN from nvidia-docker  
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04  
LABEL maintainer "Aleksander Rognhaugen"  
  
# Install basic programs and dependencies  
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \  
build-essential \  
byobu \  
curl \  
g++ \  
gcc \  
gfortran \  
git \  
make \  
nano \  
pkg-config \  
rsync \  
unzip \  
wget  
  
# Install CMake 3  
RUN cd /root && \  
wget http://www.cmake.org/files/v3.9/cmake-3.9.1.tar.gz && \  
tar -xf cmake-3.9.1.tar.gz && cd cmake-3.9.1 && \  
./bootstrap && \  
make -j"$(nproc)" && make install && \  
rm -rf /root/cmake*  
  
# Cleanup apt-get  
RUN apt-get clean && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/*  
  
# Set default working directory and image startup command  
WORKDIR "/root"  
CMD ["/bin/bash"]  

