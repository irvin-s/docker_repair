# Use an official Python runtime as a parent image
ARG FROM_IMAGE=nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
FROM ${FROM_IMAGE}

# install opencv for python 3
RUN apt-get update && \
  apt-get install -y \
  build-essential \
  cmake \
  git \
  libasound2-dev \
  libavformat-dev \
  libcanberra-gtk3-module \
  libgtk-3-dev \
  libjasper-dev \
  libjpeg-dev \
  libpng-dev \
  libpq-dev \
  libswscale-dev \
  libtbb-dev \
  libtbb2 \
  libtiff-dev \
  pkg-config \
  python3 \
  python3-numpy \
  python3-pip \
  unzip \
  wget \
  yasm

WORKDIR /
ENV OPENCV_VERSION="3.4.1"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DENABLE_AVX=ON \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3) \
  -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
&& make -j $(nproc) install \
&& rm /${OPENCV_VERSION}.zip \
&& rm -r /opencv-${OPENCV_VERSION}

# install ssd vgg model
WORKDIR /root/.chainer/dataset/_dl_cache/286b14d9978d61e62eece136d00359e5
RUN wget https://github.com/yuyu2172/share-weights/releases/download/0.0.3/ssd_vgg16_imagenet_2017_06_09.npz \
&& mkdir -p /root/.chainer/dataset/pfnet/chainercv/models \
&& cp /root/.chainer/dataset/_dl_cache/286b14d9978d61e62eece136d00359e5/ssd_vgg16_imagenet_2017_06_09.npz /root/.chainer/dataset/pfnet/chainercv/models

# Set the working directory to /app
WORKDIR /app

COPY requirements.txt requirements_cpu.txt /app/
ARG CPU_ONLY
RUN \
  if [ "x$CPU_ONLY" = "x" ] ; then \
    pip3 install -v --trusted-host pypi.python.org -r requirements.txt ; \ 
  else \
    pip3 install -v --trusted-host pypi.python.org -r requirements_cpu.txt ; \
  fi

# Copy the current directory contents into the container at /app
COPY . /app
# When developing, you should use a volume instead of rebuilding the image everytime (see Readme)

# Define environment variable
ENV NAME Schaaafrichter
