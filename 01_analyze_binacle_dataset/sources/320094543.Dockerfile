FROM ubuntu:artful
MAINTAINER Jermine.hu@qq.com
ENV OPENCV_DIR /opt/opencv
ENV LIBGPUARRAY_DIR /opt/libgpuarray
ENV NUM_CORES 8
ENV NB_UID 1000
ARG CLONE_TAG=1.0
ENV OPENCV_VERSION=3.4.1
ENV OPENCL_ENABLED=OFF

# build and install opencv
RUN apt-get update && apt-get install -y --no-install-recommends \
     python3 python3-pip python3-dev \
     protobuf-compiler \
     ffmpeg \
     build-essential \
     ca-certificates \
     libavcodec-dev libavformat-dev libavdevice-dev libv4l-dev \
     wget \
     make \
     cmake \
     g++ \
     unzip \
     x264 ;\
    pip3 install protobuf numpy six ;\
    mkdir -p /src && \
    cd /src && \
    mkdir -p $OPENCV_DIR && \
    wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip && \
    unzip $OPENCV_VERSION.zip && \
    mv /src/opencv-$OPENCV_VERSION/ $OPENCV_DIR/ && \
    rm -rf /src/$OPENCV_VERSION.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O $OPENCV_VERSION-contrib.zip && \
    unzip $OPENCV_VERSION-contrib.zip && \
    mv /src/opencv_contrib-$OPENCV_VERSION $OPENCV_DIR/ && \
    rm -rf /src/$OPENCV_VERSION-contrib.zip && \
    mkdir -p $OPENCV_DIR/opencv-$OPENCV_VERSION/build && \
    cd $OPENCV_DIR/opencv-$OPENCV_VERSION/build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D BUILD_PYTHON_SUPPORT=ON \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_CUDA=OFF \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D BUILD_PYTHON_SUPPORT=ON \
    -D BUILD_NEW_PYTHON_SUPPORT=ON \
    -D PYTHON_DEFAULT_EXECUTABLE=$(which python3) \
    -D PYTHON_INCLUDE_DIR=/usr/lib/python3.6 \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.6/dist-packages/numpy/core/include/ \
    -D OPENCV_EXTRA_MODULES_PATH=$OPENCV_DIR/opencv_contrib-$OPENCV_VERSION/modules \
    -D WITH_TBB=ON \
    -D WITH_PTHREADS_PF=ON \
    -D WITH_OPENNI=OFF \
    -D WITH_OPENNI2=ON \
    -D WITH_EIGEN=ON \
    -D BUILD_DOCS=ON \
    -D BUILD_TESTS=ON \
    -D BUILD_PERF_TESTS=ON \
    -D BUILD_EXAMPLES=ON \
    -D WITH_OPENCL=$OPENCL_ENABLED \
    -D USE_GStreamer=ON \
    -D WITH_GDAL=ON \
    -D WITH_CSTRIPES=ON \
    -D ENABLE_FAST_MATH=1 \
    -D WITH_OPENGL=ON \
    -D WITH_QT=OFF \
    -D WITH_IPP=ON \
    -D WITH_GTK=ON \
    -D WITH_FFMPEG=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_V4L=ON .. && \
    make -j8 && \
    make install && \
    ldconfig && \ 
    rm -rf $OPENCV_DIR;\
    apt remove -y \
     build-essential \
     ca-certificates \
     wget \
     libopencv-dev \
     cmake \
     g++ \
     unzip \
     x264 ;\
    apt-get autoremove && apt-get autoclean ;\
    rm -rf /var/lib/apt/lists/*
