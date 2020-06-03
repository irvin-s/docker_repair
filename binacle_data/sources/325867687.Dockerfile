# ==================================================================
# cu80-py36-tf14-t2t129-torch041
# maintrainer: Tianyu He (tim-he@qq.com)
# ------------------------------------------------------------------
# python        3.6    (apt)
# tensorflow    1.4.0  (pip)
# tensor2tensor 1.2.9  (pip)
# pytorch       0.4.1  (pip)
# ==================================================================

# FROM 10.11.3.8:5000/nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-8.0/bin:$PATH
ENV LC_ALL=C

RUN	sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
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
        libatlas-base-dev \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        libopenblas-dev \
        liblapack-dev \
        python-tk \
        openssh-client \
        openssh-server \
        time \
        tmux \
        expect && \
# ==================================================================
# python
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
        && \
    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        h5py \
        scipy \
        pandas \
        scikit-learn \
        scikit-image \
        scikit-video \
        matplotlib \
        Cython \
        visdom \
        dominate \
        protobuf \
        lmdb \
        wheel \
        nose \
        leveldb \
        Pillow \
        six \
        decorator \
        opencv-python \
        sklearn \
        imageio \
        packaging \
        tqdm \
        cffi \
        urllib3 \
        numba \
        seaborn \
        hypertools \
        fasteners \
        fjcommon \
        && \
# ==================================================================
# tensorflow 1.4.0
# tensor2tensor 1.2.9
# ------------------------------------------------------------------
    $PIP_INSTALL \
        tensorflow-gpu==1.4.0 \
        tensor2tensor==1.2.9 \
        tensorboardX==1.4 \
        && \
# ==================================================================
# pytorch 0.4.1
# ------------------------------------------------------------------
    $PIP_INSTALL \
        http://download.pytorch.org/whl/cu80/torch-0.4.1-cp36-cp36m-linux_x86_64.whl \
        torchvision

# ==================================================================
# nccl
# ------------------------------------------------------------------
WORKDIR	/opt
RUN	git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl
WORKDIR /

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
EXPOSE 6006
