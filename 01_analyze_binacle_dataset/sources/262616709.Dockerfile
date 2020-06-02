FROM ubuntu:14.04

ENV OPEN_CV_VERSION 3.1.0

RUN apt-get update \
    && apt-get install -y build-essential cmake curl pkg-config libgearman-dev

# build opencv

RUN mkdir /build

# COPY ./opencv-3.1.0.tar.gz /build/opencv-3.1.0.tar.gz

RUN cd /build \
    && wget https://github.com/opencv/opencv/archive/$OPEN_CV_VERSION.tar.gz -O - | tar xzf - \
    && tar xzf opencv-$OPEN_CV_VERSION.tar.gz \
    && cd /build/opencv-$OPEN_CV_VERSION \
    && cmake . -DWITH_IPP=OFF && make && make install \
    && rm -rf /build \
    && echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig

RUN apt-get clean && apt-get autoclean