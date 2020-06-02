FROM tensorflow/tensorflow:1.3.0-devel-gpu-py3
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf
