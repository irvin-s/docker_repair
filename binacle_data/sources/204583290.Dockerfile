############################################################
# Dockerfile to build Binjitsu container
# Based on Ubuntu
############################################################

FROM ubuntu
MAINTAINER Maintainer Cory Duplantis

RUN apt-get update && apt-get install -y software-properties-common # feb 16 2016
RUN apt-get update
RUN apt-get install -y \
    build-essential \
    curl \
    gdb \
    gdb-multiarch \
    gdbserver \
    git \
    libc6-arm64-cross \
    libc6-armhf-cross \
    libc6-dev-i386 \
    libc6-i386 \
    libffi-dev \
    libncurses5-dev \
    libncursesw5-dev \
    python-dev \
    python-dev \
    python-pip \
    python2.7 \
    python3-pip \
    tmux \
    virtualenvwrapper \
    wget

RUN git clone https://github.com/radare/radare2 \
    && cd radare2 \
    && ./sys/install.sh

RUN pip install angr --upgrade

RUN pip install --upgrade ipython
RUN useradd -m praetorian
RUN usermod -U praetorian

RUN git clone https://github.com/aquynh/capstone \
	&& cd capstone \
	&& git checkout -t origin/next \
	&& sudo ./make.sh install \
	&& cd bindings/python \
	&& python2 setup.py install \
	&& python3 setup.py install
RUN pip install --upgrade pycparser
RUN pip3 install --upgrade pycparser

RUN pip install --upgrade git+https://github.com/binjitsu/binjitsu.git # 2016-2-15

RUN git clone https://github.com/zachriggle/pwndbg /home/praetorian/pwndbg
RUN echo "source /home/praetorian/pwndbg/gdbinit.py" > /home/praetorian/.gdbinit

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN apt-get install -y vim

COPY angr-demo /home/praetorian
COPY praetorian /home/praetorian
RUN chown -R praetorian.praetorian /home/praetorian
RUN chsh -s /bin/bash praetorian
