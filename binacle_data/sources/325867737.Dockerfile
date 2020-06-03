# ==================================================================
# module list
# ------------------------------------------------------------------
# python        2.7    (apt)
# pytorch       0.4.1  (pip)
# tensorflow    1.5 (pip)
# opencv        3.4.1  (git)
# ==================================================================

#FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
FROM 10.11.3.8:5000/user-images/py27-pyth41-tf15-cu90:v1

ENV PYTHONPATH=".:$PYTHONPATH"

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple " && \
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
        vim \
        zip \
        openssh-client \
        openssh-server \
        python-tk \
        && \

# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python-pip \
        python-dev \
        && \
    $PIP_INSTALL \
        setuptools \
        pip \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        && \
    pip2 install Cython \
        && \
    $PIP_INSTALL \
        pycocotools \
        h5py \
        ipython==5.8.0 \
        scikit-image \
        easydict \
        && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

EXPOSE 6006
