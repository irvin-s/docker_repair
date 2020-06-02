FROM tensorflow/tensorflow:1.0.1-devel-gpu
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf
