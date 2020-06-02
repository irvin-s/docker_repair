FROM nvidia/cuda:8.0-cudnn5-devel 

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    python-imaging \
    python-dev \
    python-pip \
    libjpeg8 \
    libjpeg62-dev \
    libfreetype6 \
    libfreetype6-dev
    

RUN pip install chainer Pillow

COPY install.sh /root/install.sh
RUN chmod +x /root/install.sh

WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]
