# ==================================================================
# cu90-py36-tf19-t2t110-torch101
# maintrainer: NaiHua (1339417445@qq.com)
# ------------------------------------------------------------------
# python        3.6    (apt)
# tensorflow    1.9.0  (pip)
# tensor2tensor 1.10.0 (pip)
# pytorch       1.0.1  (pip)
# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-9.0/bin:$PATH
ENV LC_ALL=C

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
            decorator==4.3.0 \
            opencv-python \
            sklearn \
            imageio \
            packaging \
            tqdm \
            dlib \
            keras \
            dominate \
            requests \
            cffi \
            pytz \
            colorama \
            setproctitle \
            urllib3 \
            numba==0.41.0 \
            seaborn==0.9.0 \
            hypertools==0.5.1 \
            fasteners \
            fjcommon==0.1.69 \
            && \
# ==================================================================
# tensorflow 1.9.0
# tensor2tensor 1.10.0
# ------------------------------------------------------------------
    $PIP_INSTALL \
        tensorflow-gpu==1.9.0 \
        tensor2tensor==1.10.0 \
        tensorboardX==1.4 \
        && \
# ==================================================================
# pytorch 0.4.1
# ------------------------------------------------------------------
    $PIP_INSTALL \
        http://download.pytorch.org/whl/cu90/torch-1.0.1-cp36-cp36m-linux_x86_64.whl \
        torchvision \
        && \
# ==================================================================
# nccl
# ------------------------------------------------------------------
# WORKDIR	/opt
# RUN	git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl
# WORKDIR /
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
EXPOSE 6006
