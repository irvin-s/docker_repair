# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# tensorflow    1.8.0  (pip)
# mxnet         1.1.0  (pip)
# ==================================================================

# 选择一个基础镜像
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# 更新apt源，并安装基础软件包
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \

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
        wget \
        git \
        vim 

# 安装python 3.6和基础库
# ==================================================================
# python
# ------------------------------------------------------------------

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
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
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython 

# 安装另外一些python库
# ==================================================================
# other python libs
# ------------------------------------------------------------------

RUN pip3 install -i https://mirrors.ustc.edu.cn/pypi/web/simple \
    six \
    wheel \
    mock \
    opencv-python \
    imageio \
    tornado \
    psutil \
    pyyaml \
    easydict

# 安装tensorflow和mxnet
# ==================================================================
# tensorflow
# ------------------------------------------------------------------

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    $PIP_INSTALL \
        tensorflow-gpu==1.8.0 \
        && \

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libatlas-base-dev \
        graphviz \
        && \

    $PIP_INSTALL \
        mxnet-cu90==1.1.0 \
        graphviz \
        && \

# 清理安装过程的缓存包
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# 暴露端口
EXPOSE 22

# 设置启动命令
CMD ['/bin/bash']