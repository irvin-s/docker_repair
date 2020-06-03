# Start with cutorch base image
FROM nightseas/cuda-torch:cuda8.0-ubuntu16.04

MAINTAINER Xiaohai Li <haixiaolee@gmail.com>

# Install basic deps
RUN apt-get update && sudo apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
  python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fetch and install openCV
RUN git clone https://github.com/opencv/opencv.git /root/opencv && cd /root/opencv && git checkout 2.4.13
RUN mkdir /root/opencv/build && cd /root/opencv/build && \
  cmake -D WITH_CUDA=1 -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 \
  -D WITH_OPENMP=1 -D WITH_OPENCL=1 -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
  make -j8 && make install -j8 && \
  cd /root && rm opencv -rf

# Fetch and install dlib
RUN git clone https://github.com/davisking/dlib.git /root/dlib && cd /root/dlib && git checkout v19.0
RUN cd /root/dlib/python_examples && cmake ../tools/python && cmake --build . --config Release -- -j8 && \
  cp dlib.so /usr/local/lib/python2.7/dist-packages && \
  cd /root && rm dlib -rf
