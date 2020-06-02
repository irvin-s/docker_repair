FROM nvidia/cuda:8.0-cudnn5-devel  
MAINTAINER Daniel Petti  
  
# Install caffe dependencies.  
RUN apt-get update && \  
apt-get install -y python-numpy libboost-system-dev \  
libboost-thread-dev libboost-filesystem-dev cmake libhdf5-dev liblmdb-dev \  
libleveldb-dev libsnappy-dev libopencv-dev libatlas-base-dev python-dev \  
libboost-python-dev libgoogle-glog-dev protobuf-compiler libprotobuf-dev git  
  
# Download and install caffe.  
RUN git clone https://github.com/BVLC/caffe.git  
RUN cd caffe && mkdir build  
RUN cd caffe/build && cmake ..  
  
# Use bash.  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
RUN cd caffe/build && make -j$( grep -c ^processor /proc/cpuinfo )  
RUN cd caffe/build && make install  
  
# Install some conveniences for actually using caffe.  
RUN sudo apt-get install -y vim wget  

