FROM python:3.6.1-slim  
  
ENV BUILD_PACKAGES \  
curl \  
git \  
g++ \  
autoconf \  
automake \  
build-essential \  
checkinstall \  
cmake \  
pkg-config \  
yasm \  
libtool \  
v4l-utils \  
wget \  
tmux \  
unzip \  
libtiff5-dev \  
libpng-dev \  
libjpeg-dev \  
libjasper-dev \  
libswscale-dev \  
libdc1394-22-dev \  
libxine2-dev \  
libv4l-dev \  
libtbb-dev \  
libopencore-amrnb-dev \  
libopencore-amrwb-dev \  
libtheora-dev \  
libxml2-dev \  
libxslt1-dev  
  
  
ENV OPENCV_VERSION=3.2.0  
  
WORKDIR /tmp  
  
# Install opencv prerequisites...  
RUN apt-get update -qq && \  
apt-get install -y --force-yes $BUILD_PACKAGES && \  
apt-get clean  
  
RUN pip3 install --no-cache-dir numpy  
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \  
unzip ${OPENCV_VERSION}.zip && \  
cd /tmp/opencv-${OPENCV_VERSION} && \  
mkdir /tmp/opencv-${OPENCV_VERSION}/build && \  
cd /tmp/opencv-${OPENCV_VERSION}/build && \  
cmake -D CMAKE_BUILD_TYPE=RELEASE \  
-D CMAKE_INSTALL_PREFIX=/usr/local \  
-D WITH_TBB=ON \  
-D BUILD_PYTHON_SUPPORT=ON \  
-D WITH_V4L=OFF \  
# -D INSTALL_C_EXAMPLES=ON \ bug w/ tag=3.2.0: cmake has error  
-D INSTALL_PYTHON_EXAMPLES=OFF \  
-D BUILD_EXAMPLES=OFF \  
-D BUILD_DOCS=OFF \  
# -D OPENCV_EXTRA_MODULES_PATH=/usr/local/src/opencv_contrib/modules \  
-D WITH_XIMEA=OFF \  
-D WITH_QT=OFF \  
-D WITH_FFMPEG=OFF \  
-D WITH_PVAPI=YES \  
-D WITH_GSTREAMER=OFF \  
-D WITH_TIFF=YES \  
-D WITH_OPENCL=YES \  
-D BUILD_opencv_python2=OFF \  
-D BUILD_opencv_python3=ON \  
-D PYTHON3_EXECUTABLE=/usr/local/bin/python \  
-D PYTHON3_INCLUDE_DIR=/usr/local/include/python3.6m \  
-D PYTHON3_LIBRARY=/usr/local/lib/libpython3.so \  
-D PYTHON_LIBRARY=/usr/local/lib/libpython3.so \  
-D PYTHON3_PACKAGES_PATH=/usr/local/lib/python3.6/site-packages \  
-D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.6/site-packages/numpy/core/include \  
.. && \  
make -j2 && \  
make install && \  
echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf && \  
ldconfig && \  
rm -rf /tmp/opencv-${OPENCV_VERSION} && \  
rm -rf /tmp/${OPENCV_VERSION}.zip  
  
RUN ln -s /dev/null /dev/raw1394  

