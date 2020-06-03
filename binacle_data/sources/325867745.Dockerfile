# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (conda)
# pytorch       0.4.1  (conda)
# tensorboardx  1.4    (conda)
# ffpmeg        4.0.2  (conda)
# ==================================================================
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ENV PATH /opt/conda/bin:$PATH
ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple" && \
    GIT_CLONE="git clone --depth 10" && \
    CONDA_INSTALL="conda install -y" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        apt-utils \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        openssh-client \
        openssh-server \
        libboost-dev \
        libboost-thread-dev \
        libboost-filesystem-dev \
        && \
# ==================================================================
# miniconda
# ------------------------------------------------------------------
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
        /bin/bash ~/miniconda.sh -b -p /opt/conda && \
        rm ~/miniconda.sh && \
        #echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc && \
# ==================================================================
# conda
# ------------------------------------------------------------------
    conda config --set show_channel_urls yes && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    $CONDA_INSTALL \
        python=3.6 && \
    $CONDA_INSTALL \
        ipython \
        Cython \
        ffmpeg \
        pytorch=0.4.0 \
        sk-video \
        imageio \
        h5py \
        tensorboardx \
        torchvision=0.2.1 \
        cffi \
        && \
    $PIP_INSTALL \
        lmdb \
        opencv-contrib-python \
        matplotlib \
        tqdm \
        scikit-learn \
        pytest \
        && \
    conda clean -y --all && \
# ==================================================================
# warpctc
# ------------------------------------------------------------------
    $GIT_CLONE https://github.com/Rhythmblue/warp-ctc.git /usr/local/warp-ctc && \
    mkdir -p /usr/local/warp-ctc/build && cd /usr/local/warp-ctc/build && \
    cmake .. && \
    make -j 4 && \
    cd /usr/local/warp-ctc/pytorch_binding && python setup.py install && \
# ==================================================================
# ctcdecode
# ------------------------------------------------------------------
    $GIT_CLONE --recursive https://github.com/Rhythmblue/ctcdecode.git /usr/local/ctcdecode && \
    cd /usr/local/ctcdecode && \
    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple . && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
EXPOSE 6006