# Use latest python3 alpine base - https://github.com/docker-library/python
FROM python:3.5.2-alpine

MAINTAINER Marc Young <marcus.h.young@gmail.com>

# Install development tools/libraries and openvc3 dependencies 
RUN apk update && apk upgrade \
    && apk add --no-cache bash libwebp ffmpeg jpeg tiff libpng jasper \
    && apk add --no-cache --virtual .dev-deps git gcc g++ clang make cmake ninja clang-dev  musl-dev libwebp-dev ffmpeg-dev jpeg-dev tiff-dev libpng-dev jasper-dev linux-headers \
    && apk add --no-cache -X http://dl-3.alpinelinux.org/alpine/edge/testing/ openblas openblas-dev \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h

# Set environment to clang toolchain
ENV CC /usr/bin/clang
ENV CXX /usr/bin/clang++

# Install Cython v0.24.1 and Numpy v1.11.1
RUN pip3 install --no-cache-dir --upgrade cython==0.24.1 numpy==1.11.1

# Get OpenCV v3.1.0 and Contrib Source
WORKDIR /usr/local/src
RUN git clone --depth 1 -b '3.1.0' https://github.com/opencv/opencv.git \
    && git clone --depth 1 -b '3.1.0' https://github.com/opencv/opencv_contrib.git \
    && mkdir -p opencv/release

# Build and install OpenCV3
WORKDIR /usr/local/src/opencv/release
RUN cmake -G Ninja \
          -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_TBB=OFF \
          -D WITH_V4L=OFF \
          -D WITH_FFMPEG=YES \
          -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
          .. \
    && ninja \
    && ninja install \
    && apk del .dev-deps \
    && apk del openblas-dev \
    && rm -rf /var/cache/apk/*

# Symblink cv2 to actual cv2 installed library
WORKDIR /usr/local/lib/python3.5/site-packages
RUN ln -s cv2.cpython-35m-x86_64-linux-gnu.so cv2.so

# Post install cleanup
WORKDIR /usr/local
RUN rm -rf src

CMD ["python3"]