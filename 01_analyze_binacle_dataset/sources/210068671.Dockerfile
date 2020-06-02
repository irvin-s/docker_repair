FROM tensorflow/tensorflow:1.0.0-devel
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf

RUN apt-get update \
    && apt-get install libtcmalloc-minimal4 
ENV LD_PRELOAD="/usr/lib/libtcmalloc_minimal.so.4"
