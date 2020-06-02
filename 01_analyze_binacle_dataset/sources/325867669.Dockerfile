# ==================================================================
#
# ------------------------------------------------------------------
# pytorch       1.0.1  (pip3)
# ==================================================================

FROM 10.11.3.8:5000/nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER jackyue <jackyue.ai@gmail.com>

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-8.0/bin:$PATH
ENV LC_ALL=C
ENV LANG=en_US.UTF8
ENV LESSCHARSET=UTF-8
ENV PYTHONIOENCODING=UTF-8

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple " && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        git \
        wget \
        vim \
        zip \
        cmake \
        gcc \
        g++ \
        openssh-server \
        openssh-client \
        curl \
        htop \
        tmux \
        vim \
        time \
        dstat \
        lsof \
        tree \
        rsync \
        lrzsz \
        zsh \
        unzip \
        net-tools \
        sysstat \
        screen \
        tcpdump \
        nmap \
        iftop \
        python-tk \
        expect \
        && \
# ==================================================================
# pytorch 1.0.0
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:jonathonf/python-3.6 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
        pip \
        setuptools \
        && \
    $PIP_INSTALL \
    http://download.pytorch.org/whl/cu90/torch-1.0.1-cp36-cp36m-linux_x86_64.whl \
        torchvision

RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

COPY ./GPU-light-up  GPU-light-up

WORKDIR GPU-light-up  

CMD ["/bin/bash", "GPU-light-up.sh"]
