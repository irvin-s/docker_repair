FROM nvidia/cuda:7.5-cudnn3-devel-ubuntu14.04  
MAINTAINER Daniel Petti  
  
# Install caffe dependencies.  
RUN apt-get update  
RUN apt-get install -y python-numpy libboost-system-dev \  
libboost-thread-dev libboost-filesystem-dev libhdf5-dev liblmdb-dev \  
libleveldb-dev libsnappy-dev libopencv-dev libatlas-base-dev python-dev \  
libboost-python-dev libgoogle-glog-dev git  
  
# Install a non-old version of cmake.  
RUN apt-get install -y software-properties-common  
RUN add-apt-repository ppa:george-edison55/cmake-3.x  
RUN apt-get update  
RUN apt-get install -y cmake  
  
# Install protobuf dependencies.  
RUN apt-get install -y unzip autoconf automake curl libtool  
# Install protobuf.  
RUN git clone https://github.com/google/protobuf.git  
RUN cd protobuf && ./autogen.sh  
RUN cd protobuf && ./configure --prefix=/usr  
RUN cd protobuf && make -j8  
RUN cd protobuf && make -j8 check  
RUN cd protobuf && make install  
RUN ldconfig  
# Build the python bindings.  
RUN apt-get install -y python-pip  
RUN pip install setuptools  
RUN cd protobuf/python && python setup.py build --cpp_implementation  
RUN cd protobuf/python && python setup.py test \--cpp_implementation  
RUN cd protobuf/python && python setup.py install  
  
# Install dependencies for faster-rcnn.  
RUN apt-get install -y python-opencv python-skimage  
RUN pip install cython easydict pyaml  
  
# Edit the matplotlib config.  
COPY matplotlibrc /etc/matplotlibrc  
  
# Copy the script that allows us to run GUI apps.  
COPY setup_gui_env.sh /  

