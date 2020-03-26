# FROM openhorizon/cuda-tx1-full
# OR
FROM openhorizon/cuda-tx1-fullcudnn

MAINTAINER dyec@us.ibm.com
#AUTHOR dima@us.ibm.com

ENV ARCH=arm64

RUN apt-get update && apt-get install -y --no-install-recommends build-essential cmake git gfortran libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev libhdf5-serial-dev libleveldb-dev liblmdb-dev libopencv-dev libprotobuf-dev libsnappy-dev protobuf-compiler python-all-dev python-dev python-h5py python-matplotlib python-numpy python-opencv python-pil python-pip python-protobuf python-scipy python-skimage python-sklearn

WORKDIR /
# RUN git clone https://github.com/NVIDIA/caffe.git
RUN git clone https://github.com/BVLC/caffe
WORKDIR /caffe

RUN apt-get install -y python-setuptools
# RUN cat python/requirements.txt | xargs -n1 sudo pip install
WORKDIR /caffe/python
RUN for req in $(cat requirements.txt); do pip install $req; done
WORKDIR /caffe
RUN cp Makefile.config.example Makefile.config
# RUN mkdir build
# WORKDIR /caffe/build
# RUN cmake 
RUN sed -i "s/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include \/usr\/include\/hdf5\/serial/g" Makefile.config
RUN sed -i "s/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial/g" Makefile
RUN sed -i "s/# USE_CUDNN := 1/USE_CUDNN := 1/g" Makefile.config

# ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/tegra
RUN make all -j4
RUN make pycaffe -j4
RUN make test -j4
RUN make distribute
