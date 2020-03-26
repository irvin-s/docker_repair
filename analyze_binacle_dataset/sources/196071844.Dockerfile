# Start with CUDA Caffe dependencies 
FROM kaixhin/cuda-caffe-deps:7.5 
MAINTAINER Kai Arulkumaran <design@kaixhin.com>

# Move into Caffe repo 
RUN cd /root/caffe && \
# Make and move into build directory
mkdir build && cd build && \
# CMake 
cmake .. && \ 
# Make 
make -j"$(nproc)" all && \ 
make install 
# Add to Python path 
ENV PYTHONPATH=/root/caffe/python:$PYTHONPATH 
# Set ~/caffe as working directory 
WORKDIR /root/caffe

#FROM kaixhin/cuda-caffe
#MAINTAINER Chris Chow <chris.kr.chow@gmail.com>
# install fast-rcnn's deps
RUN apt-get update && \
	apt-get install -y git python-numpy cython python-pip python-skimage \
	python-protobuf python-opencv python-pandas python-yaml python-sklearn \
	octave python-ipdb

RUN	pip install easydict && pip install "ipython[notebook]"

# octave is good enough for the PASCAL VOC stuff
RUN ln -s /usr/bin/octave /usr/bin/matlab

# build fast-rcnn
RUN cd /opt && \
	git clone --recursive https://github.com/rbgirshick/fast-rcnn.git

ADD Makefile.config /opt/fast-rcnn/caffe-fast-rcnn/Makefile.config

RUN	cd /opt/fast-rcnn/lib && make -j4 && \
	cd ../caffe-fast-rcnn && make -j4 && make -j4 pycaffe
