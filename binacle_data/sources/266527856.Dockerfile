FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2-RC

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com

ENV ARCH=arm64

# Install package dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential cmake git gfortran libatlas-base-dev libboost-all-dev libgflags-dev libgoogle-glog-dev libhdf5-serial-dev libleveldb-dev liblmdb-dev libopencv-dev libprotobuf-dev libsnappy-dev protobuf-compiler python-all-dev python-dev python-opencv python-pip python-setuptools

# Install python dependencies
RUN pip install --upgrade --no-cache-dir pip setuptools wheel
RUN pip install --no-cache-dir pillow numpy matplotlib h5py protobuf scipy scikit-image scikit-learn

WORKDIR /
RUN git clone https://github.com/BVLC/caffe
WORKDIR /caffe/python
RUN for req in $(cat requirements.txt); do pip install $req; done
WORKDIR /caffe
RUN cp Makefile.config.example Makefile.config

# Prep make with the correct python include dirs
RUN sed -i "s/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include \/usr\/include\/hdf5\/serial/g" Makefile.config
RUN sed -i "s/# USE_CUDNN := 1/USE_CUDNN := 1/g" Makefile.config
# CUDA9.0 update: Comment out "compute_20" lines in makefile.config.. this arch is obsolete
RUN sed -i "s/-gencode arch=compute_20,code=sm_20/#-gencode arch=compute_20,code=sm_20/g" Makefile.config
RUN sed -i "s/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial/g" Makefile

# Build
RUN make all -j4
RUN make pycaffe -j4
RUN make test -j4
RUN make distribute

# Clean up
RUN apt-get -y remove python-pip
RUN apt-get -y autoremove && apt-get -y clean

