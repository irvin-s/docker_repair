FROM ubuntu:14.04 as build

LABEL maintainer="Edgar Aroutiounian <edgar.factorial@gmail.com>"

ARG DEBIAN_FRONTEND=noninteractive

ARG BUILD_DIR=/home/build-dep

ARG OPENFACE_DIR=/home/openface-build

RUN mkdir ${OPENFACE_DIR}
WORKDIR ${OPENFACE_DIR}

COPY ./CMakeLists.txt ${OPENFACE_DIR}

COPY ./cmake ${OPENFACE_DIR}/cmake

COPY ./exe ${OPENFACE_DIR}/exe

COPY ./lib ${OPENFACE_DIR}/lib

ADD https://www.dropbox.com/s/7na5qsjzz8yfoer/cen_patches_0.25_of.dat?dl=1 \
    ${OPENFACE_DIR}/lib/local/LandmarkDetector/model/patch_experts/cen_patches_0.25_of.dat

ADD https://www.dropbox.com/s/k7bj804cyiu474t/cen_patches_0.35_of.dat?dl=1 \
    ${OPENFACE_DIR}/lib/local/LandmarkDetector/model/patch_experts/cen_patches_0.35_of.dat

ADD https://www.dropbox.com/s/ixt4vkbmxgab1iu/cen_patches_0.50_of.dat?dl=1 \
    ${OPENFACE_DIR}/lib/local/LandmarkDetector/model/patch_experts/cen_patches_0.50_of.dat

ADD https://www.dropbox.com/s/2t5t1sdpshzfhpj/cen_patches_1.00_of.dat?dl=1 \
    ${OPENFACE_DIR}/lib/local/LandmarkDetector/model/patch_experts/cen_patches_1.00_of.dat

RUN mkdir ${BUILD_DIR}

ADD https://github.com/opencv/opencv/archive/3.4.0.zip ${BUILD_DIR}

RUN apt-get update && apt-get install -qq -y \
    curl build-essential llvm clang-3.7 libc++-dev \
    libc++abi-dev cmake libopenblas-dev liblapack-dev git libgtk2.0-dev \
    pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev \
    libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev checkinstall \
    libboost-all-dev wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN cd ${BUILD_DIR} && unzip 3.4.0.zip && \
    cd opencv-3.4.0 && \
    mkdir -p build && \
    cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_TBB=ON -D WITH_CUDA=OFF \
    -D BUILD_SHARED_LIBS=OFF .. && \
    make -j4 && \
    make install

RUN cd ${OPENFACE_DIR} && mkdir -p build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE .. && \
    make -j4

RUN ln /dev/null /dev/raw1394
ENTRYPOINT ["/bin/bash"]
