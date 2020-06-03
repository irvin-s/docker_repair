FROM ubuntu
LABEL maintainer="Alyssa Quek <alyssaquek@gmail.com>"

ENV OPENCV_VERSION="3.4.1"
ENV STASM_VERSION="stasm4.1.0"

RUN apt-get update && \
  apt-get install -y \
  build-essential \
  cmake \
  git \
  wget

WORKDIR /

RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz \
&& tar -xvzf ${OPENCV_VERSION}.tar.gz \
&& mkdir /opencv-${OPENCV_VERSION}/build \
&& cd /opencv-${OPENCV_VERSION}/build \
&& cmake -DBUILD_TIFF=OFF \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DENABLE_AVX=OFF \
  -DWITH_OPENGL=OFF \
  -DWITH_OPENCL=OFF \
  -DWITH_IPP=OFF \
  -DWITH_TBB=OFF \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=OFF \
  -DWITH_PROTOBUF=OFF \
  -DWITH_IMGCODEC_HDR=OFF \
  -DWITH_IMGCODEC_SUNRASTER=OFF \
  -DWITH_IMGCODEC_PXM=OFF \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.tar.gz \
&& rm -r /opencv-${OPENCV_VERSION}

RUN wget http://www.milbo.org/stasm-files/6/${STASM_VERSION}.tar.gz \
  && tar -xvzf ${STASM_VERSION}.tar.gz \
  && rm ${STASM_VERSION}.tar.gz \
  && cd ${STASM_VERSION} \
  && git clone https://github.com/alyssaq/stasm_build.git \
  && ./stasm_build/build.sh
