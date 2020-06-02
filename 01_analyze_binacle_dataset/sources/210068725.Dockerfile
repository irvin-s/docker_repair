FROM tensorflow/tensorflow:1.4.0-devel
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf
