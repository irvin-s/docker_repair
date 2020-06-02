FROM tensorflow/tensorflow:0.12.0-gpu
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf
