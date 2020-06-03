# Use an official mellanox/docker-tf-1-3 as a parent image
FROM mellanox/docker-tf-1-3

#------------------ Some basic configurations ------------------
# Author
MAINTAINER zhuzhikai <zhuzhikai@leinao.ai>

# Word directory
WORKDIR /root

#------------------ Install some packages ------------------
# Pick up some MOFED dependencies

RUN apt-get update && \
    apt-get install --assume-yes apt-utils && \
    apt-get install -y --no-install-recommends rar unrar openssh-server nvidia-modprobe python3-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip install tqdm 

RUN pip3 install setuptools && pip3 install tqdm
