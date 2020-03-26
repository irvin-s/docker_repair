FROM tensorflow/tensorflow:1.7.0-devel-gpu-py3

LABEL maintainer="richard@nodeflux.io"

# Initial Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        cmake \
        cython3 \
        g++ \
        git \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \ 
        libjasper-dev \
        libavformat-dev \
        libpq-dev \
        libgtk2.0-dev \
        pkg-config \
        python3-dev \
        python3-wheel \
        wget \
        unzip \
        yasm && \
    rm -rf /var/lib/apt/lists/*


# Build OpenCV
ENV OPENCV_VERSION="3.3.1" 
COPY 3.3.1.zip /

WORKDIR / 
RUN unzip ${OPENCV_VERSION}.zip && \ 
    mkdir /opencv-${OPENCV_VERSION}/cmake_binary && \
    cd /opencv-${OPENCV_VERSION}/cmake_binary && \
    cmake \
        -DBUILD_TIFF=ON \ 
        -DBUILD_opencv_java=OFF \
        -DWITH_CUDA=OFF \
        -DENABLE_AVX=ON \
        -DWITH_OPENGL=ON \
        -DWITH_OPENCL=ON \
        -DWITH_IPP=ON \
        -DWITH_TBB=ON \
        -DWITH_EIGEN=ON \
        -DWITH_V4L=ON \
        -DWITH_GTK=ON \
        -DWITH_GTK_2_X=ON \
        -DBUILD_TESTS=OFF \
        -DBUILD_PERF_TESTS=OFF \
        -DCMAKE_BUILD_TYPE=RELEASE \
        -DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
        -DPYTHON_EXECUTABLE=$(which python3) \
        -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
        -D PYTHON3_NUMPY_INCLUDE_DIRS:PATH=/usr/local/lib/python3.5/dist-packages/numpy/core/include \
        -DPYTHON_PACKAGES_PATH=/usr/local/lib/python3.5/dist-packages .. && \
    make -j "$(nproc)" install && \
    rm /${OPENCV_VERSION}.zip && \
    rm -r /opencv-${OPENCV_VERSION}
    
# Build Darkflow
COPY darkflow /darkflow

RUN cd darkflow && \
    pip3 install .

# Build TensorRT

ENV TENSORRT_VERSION 3.0

COPY nv-tensorrt-repo-ubuntu1604-ga-cuda9.0-trt3.0.4-20180208_1-1_amd64.deb /tmp/

RUN cd /tmp/ && \
    dpkg -i nv-tensorrt-repo-ubuntu1604-ga-cuda9.0-trt3.0.4-20180208_1-1_amd64.deb && \
    apt-get update && apt-get install -y --no-install-recommends \
        tensorrt \
        python3-libnvinfer-doc \
        uff-converter-tf && \
    rm -rf nv-tensorrt-repo-ubuntu1604-ga-cuda9.0-trt3.0.4-20180208_1-1_amd64.deb

# Upgrade numpy and pillow version for tensorRT
RUN pip3 install --upgrade \
        numpy \
        pillow \
        enum34 

# Install pyCUDA
WORKDIR /
ADD pycuda-2017.1.1.tar.gz /

#RUN tar -xzvf / pycuda-2017.1.1.tar.gz && \
#    rm -rf pycuda-2017.1.1.tar.gz

ENV CUDA_ROOT=/usr/local/cuda

RUN cd pycuda-2017.1.1 && \
    #rm ./siteconf.py && \
    python3 configure.py && \
    make -j "$(nproc)" install && \
    pip3 install .