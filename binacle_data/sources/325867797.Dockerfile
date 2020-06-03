# base-image
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

MAINTAINER Hantao Zhang <zht1994@mail.ustc.edu.cn>

# install dependency packages
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
        /etc/apt/sources.list.d/cuda.list \
        /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        autossh \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        git \
        graphviz \
        htop \
        libmysqlclient-dev \
        liblapack-dev \
        libopenblas-dev \
        libopencv-dev \
        locales \
        openssh-client \
        openssh-server \
        tmux \
        unzip \
        vim \
        wget \
        zip

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
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
    pip3 install -i https://mirrors.ustc.edu.cn/pypi/web/simple \ 
    #$PIP_INSTALL \
        setuptools \
        && \
    pip3 install -i https://mirrors.ustc.edu.cn/pypi/web/simple \
    #$PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython 

RUN pip3 install -i https://mirrors.ustc.edu.cn/pypi/web/simple \
    backcall \
    certifi \
    chardet \
    cycler \
    decorator \
    easydict \
    graphviz \
    idna \
    imageio \
    ipython \
    ipython-genutils \
    jedi \
    kiwisolver \
    mock \
    opencv-python \
    parso \
    pexpect \
    pickleshare \
    Pillow \
    pipenv \
    prompt-toolkit \
    psutil \
    ptyprocess \
    pyarrow \
    Pygments \
    pyparsing \
    python-dateutil \
    pytz \
    pyyaml \
    pyzmq \
    requests \
    six \
    tornado \
    tqdm \
    traitlets \
    urllib3==1.24.2 \
    virtualenv \
    virtualenv-clone \
    wcwidth \
    wheel 

# Install a patched cocotools for python3
RUN pip3 install -i https://mirrors.ustc.edu.cn/pypi/web/simple 'git+https://github.com/RogerChern/cocoapi.git#subdirectory=PythonAPI'

# build mxnet from source
COPY ./mxnet /tmp/mxnet

RUN cd /tmp/mxnet && \
	echo "USE_OPENCV = 0" >> ./config.mk && \
	echo "USE_MKLDNN = 0" >> ./config.mk && \
	echo "USE_BLAS = openblas" >> ./config.mk && \
	echo "USE_CUDA = 1" >> ./config.mk && \
	echo "USE_CUDA_PATH = /usr/local/cuda" >> ./config.mk && \
	echo "USE_CUDNN = 1" >> ./config.mk && \
	echo "USE_NCCL = 1" >> ./config.mk && \
	echo "USE_DIST_KVSTORE = 1" >> ./config.mk && \
	echo "CUDA_ARCH = -gencode arch=compute_50,code=sm_50 -gencode arch=compute_60,code=sm_60 -gencode arch=compute_70,code=sm_70" >> ./config.mk && \
	make -j40 && \
    cd python && \
    python3 setup.py install && \
    rm -rf /tmp/mxnet

# clean-up
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove
    #rm -rf mxnet
    #rm -rf /var/lib/apt/lists/* /tmp/* ~/*
