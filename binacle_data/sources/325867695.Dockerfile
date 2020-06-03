# ==================================================================
# module list
# ------------------------------------------------------------------
# conda         3.6    (apt)
# pytorch       1.0.1  (pip)
# tensorflow    1.12.0 (pip)
# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
ENV APT_INSTALL="apt-get install -y --no-install-recommends" \
    PIP_INSTALL="python -m pip install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple " \
    GIT_CLONE="git clone --depth 10" \
    CONDA_INSTALL="conda install -y" \
    PATH=/home/ddlee/conda/bin:$PATH
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update

# ==================================================================
# add user
# ------------------------------------------------------------------

RUN DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
    sudo && \
    useradd -m ddlee -u 1000 -g root -G sudo -s /bin/bash && \
    echo "ddlee:admin" | chpasswd && \
    echo "ddlee ALL=(ALL) ALL" >> /etc/sudoers

# ==================================================================
# tools
# ------------------------------------------------------------------

RUN DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        cmake \
        nano \
        wget \
        git \
        zip \
        unzip \
        htop \
        tmux \
        curl \
        openssh-server \
        openssh-client \
        libgtk2.0-dev

# ==================================================================
# conda
# ------------------------------------------------------------------

USER ddlee
RUN wget --quiet https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /home/ddlee/conda && \
    rm ~/miniconda.sh && \
    echo "export PATH=/home/ddlee/condabin:$PATH" >> ~/.bashrc && \
    export PATH=/home/ddlee/conda/bin:$PATH && \
    conda config --set show_channel_urls yes && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
    $CONDA_INSTALL \
        ipython \
        visdom \
        tensorboardx \
        opencv
RUN $PIP_INSTALL \
        pip \
        numpy \
        scipy \
        pandas \
        cloudpickle \
        scikit-learn \
        scikit-image \
        matplotlib \
        opencv-python \
        Cython \
        gpustat \
        pipenv \
        jupyter \
        jupyterlab \
        visdom \
        tqdm \
        pytest \
        easydict

# ==================================================================
# pytorch
# ------------------------------------------------------------------

RUN $PIP_INSTALL \
        future \
        numpy \
        protobuf \
        enum34 \
        pyyaml \
        typing \
        torch \
        torchvision

# ==================================================================
# tensorflow
# ------------------------------------------------------------------

RUN $PIP_INSTALL \
        tensorflow-gpu==1.12.0

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

USER root
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# ==================================================================
# Set ENV Vars
# ------------------------------------------------------------------

ENV LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8
            # ==================================================================
# config pip
# ------------------------------------------------------------------

USER ddlee
RUN mkdir /home/ddlee/.pip && \
    echo "[global]" > /home/ddlee/.pip/pip.conf && \
    sed -i -e "\$aindex-url=https://pypi.tuna.tsinghua.edu.cn/simple" /home/ddlee/.pip/pip.conf && \
    mkdir /home/ddlee/working
WORKDIR /home/ddlee/working

EXPOSE 22 8888 8097 6006
