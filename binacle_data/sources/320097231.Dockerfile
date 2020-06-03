FROM alpine

ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++
ENV OPENCV_VERSION=3.4.0

RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
  >> /etc/apk/repositories

RUN apk add --update --no-cache \
      build-base \
      openblas-dev \
      unzip \
      wget \
      cmake \
      # A C language family front-end for LLVM (development files)
      clang-dev \
      qt5-qtbase-dev \
      linux-headers && \ 

    mkdir -p /opt && \
    cd /opt && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    rm -rf ${OPENCV_VERSION}.zip && \

    # download and extract opencv-contrib
    wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    rm -rf ${OPENCV_VERSION}.zip && \

    mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
    cd /opt/opencv-${OPENCV_VERSION}/build && \
    cmake \
      -D CMAKE_FIND_LIBRARY_SUFFIXES=.a \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D BUILD_SHARED_LIBS=OFF \
      -D WITH_FFMPEG=OFF \
      -D WITH_1394=OFF \
      -D WITH_IPP=OFF \
      -D WITH_QT=ON \
      -D WITH_OPENEXR=OFF \
      -D WITH_TBB=YES \
      -D WITH_WEBP=OFF \
      -D WITH_TIFF=OFF \
      -D WITH_PNG=OFF \
      -D WITH_JASPER=OFF \
      -D BUILD_TBB=ON \
      -D BUILD_JPEG=ON \
      -D BUILD_IPP_IW=OFF \
      -D BUILD_ZLIB=ON \
      -D BUILD_FAT_JAVA_LIB=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D BUILD_ANDROID_EXAMPLES=OFF \
      -D INSTALL_PYTHON_EXAMPLES=OFF \
      -D BUILD_DOCS=OFF \
      -D BUILD_opencv_python2=OFF \
      -D BUILD_opencv_python3=OFF \
      -D BUILD_opencv_apps=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib-${OPENCV_VERSION}/modules \
      .. && \
      make -j "$(getconf _NPROCESSORS_ONLN)" && \
      make install && \
      rm -rf /opt/opencv-${OPENCV_VERSION} && \
      rm -rf /opt/opencv_contrib-${OPENCV_VERSION}
