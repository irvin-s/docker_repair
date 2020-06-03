FROM golang:alpine

RUN echo -e '@edgunity http://nl.alpinelinux.org/alpine/edge/community\n\
@edge http://nl.alpinelinux.org/alpine/edge/main\n\
@testing http://nl.alpinelinux.org/alpine/edge/testing\n\
@community http://dl-cdn.alpinelinux.org/alpine/edge/community'\
  >> /etc/apk/repositories

RUN apk update && apk upgrade

RUN apk add --update --no-cache build-base openblas-dev \
      unzip wget cmake libtbb@testing  libtbb-dev@testing   \
      libjpeg  libjpeg-turbo-dev libpng-dev \
      jasper-dev tiff-dev libwebp-dev clang-dev linux-headers \
      ffmpeg ffmpeg-dev bash git

RUN mkdir /tmp/opencv && \
  cd /tmp/opencv && \
  wget -O opencv.zip https://github.com/opencv/opencv/archive/3.4.1.zip && \
  unzip opencv.zip && \
  wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/3.4.1.zip && \
  unzip opencv_contrib.zip

RUN mkdir -p /tmp/opencv/opencv-3.4.1/build
WORKDIR /tmp/opencv/opencv-3.4.1/build


RUN	cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv/opencv_contrib-3.4.1/modules -D BUILD_DOCS=OFF BUILD_EXAMPLES=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_java=OFF -D BUILD_opencv_python=OFF -D WITH_FFMPEG=ON -D BUILD_opencv_python2=OFF -D BUILD_opencv_python3=OFF .. 
RUN	make -j4 
RUN	make install
RUN	ldconfig .

WORKDIR ~
RUN rm -rf /tmp/opencv
