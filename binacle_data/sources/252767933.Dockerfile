# Dockerfile with tensorflow gpu support on python2, opencv3.3.0  
FROM tensorflow/tensorflow:1.4.1-gpu  
  
MAINTAINER whenyd <whenyd@126.com>  
  
RUN apt-get update  
  
# Core linux dependencies.  
RUN apt-get install -y \  
# developer tools  
build-essential \  
cmake \  
git \  
wget \  
unzip \  
yasm \  
pkg-config \  
# image formats support  
libtbb2 \  
libtbb-dev \  
libjpeg-dev \  
libpng-dev \  
libtiff-dev \  
libjasper-dev \  
libhdf5-dev \  
# video formats support  
libavcodec-dev \  
libavformat-dev \  
libswscale-dev \  
libv4l-dev \  
libxvidcore-dev \  
libx264-dev  
  
# Python dependencies  
RUN pip --no-cache-dir install \  
numpy \  
hdf5storage \  
h5py \  
scipy \  
keras  
  
WORKDIR /  
  
RUN wget https://github.com/opencv/opencv_contrib/archive/3.3.0.zip \  
&& unzip 3.3.0.zip \  
&& rm 3.3.0.zip  
  
RUN wget https://github.com/opencv/opencv/archive/3.3.0.zip \  
&& unzip 3.3.0.zip \  
&& mkdir /opencv-3.3.0/build \  
&& cd /opencv-3.3.0/build \  
&& cmake -DBUILD_TIFF=ON \  
-DBUILD_opencv_java=OFF \  
-DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.3.0/modules \  
-DWITH_CUDA=OFF \  
-DENABLE_AVX=ON \  
-DWITH_OPENGL=ON \  
-DWITH_OPENCL=ON \  
# cannot download ippicv  
-DWITH_IPP=ON \  
-DWITH_TBB=ON \  
-DWITH_EIGEN=ON \  
-DWITH_V4L=ON \  
-DBUILD_TESTS=OFF \  
-DBUILD_PERF_TESTS=OFF \  
-DCMAKE_BUILD_TYPE=RELEASE \  
-DCMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \  
-DPYTHON_EXECUTABLE=$(which python) \  
-DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \  
-DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \  
&& make install \  
&& rm /3.3.0.zip \  
&& rm -r /opencv-3.3.0 \  
&& ldconfig  
  
CMD ["/bin/bash"]  

