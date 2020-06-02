FROM nvidia/cuda:9.0-devel-ubuntu16.04

# TensorFlow version is tightly coupled to CUDA and cuDNN so it should be selected carefully
ENV TENSORFLOW_VERSION=1.12.0
ENV PYTORCH_VERSION=1.0.0
ENV CUDNN_VERSION=7.4.1.5-1+cuda9.0
ENV NCCL_VERSION=2.4.2-1+cuda9.0
ENV MXNET_URL=https://s3-us-west-2.amazonaws.com/mxnet-python-packages-gcc5/mxnet_cu90_gcc5-1.4.0-py2.py3-none-manylinux1_x86_64.whl

#  Set MOFED directory, image and working directory
ENV MOFED_DIR MLNX_OFED_LINUX-4.2-1.0.0.0-ubuntu16.04-x86_64
ENV MOFED_SITE_PLACE MLNX_OFED-4.2-1.0.0.0
ENV MOFED_IMAGE MLNX_OFED_LINUX-4.2-1.0.0.0-ubuntu16.04-x86_64.tgz

WORKDIR /root

RUN apt-get update 

RUN apt-get install -y --allow-downgrades --allow-change-held-packages --no-install-recommends \
        build-essential \
        cmake \
        git \
        curl \
        vim \
        wget \
	net-tools \
        ethtool \
        perl \
        vim \
        lsb-release \
        iproute2 \
        pciutils \
        libnl-route-3-200 \
        kmod \
        libnuma1 \
        lsof \
        iputils-ping \
        traceroute \
        ca-certificates \
        openssh-client \ 
        openssh-server \
        subversion \
        libcudnn7=${CUDNN_VERSION} \
        libnccl2=${NCCL_VERSION} \
        libnccl-dev=${NCCL_VERSION} \
        libjpeg-dev \
        libpng-dev \
        cython \		
        python-dev \
	python3-dev \
	python-pip \
	python3-pip \
	python-tk \
	python3-tk \
        python-libxml2 \
        python-setuptools \
        python3-setuptools \
        linux-headers-4.4.0-92-generic && \
        rm -rf /var/lib/apt/lists/*		

# Install TensorFlow, Keras, PyTorch and MXNet
RUN pip install 'numpy<1.15.0' tensorflow-gpu==${TENSORFLOW_VERSION} keras h5py torch==${PYTORCH_VERSION} torchvision ${MXNET_URL}
RUN pip3 install 'numpy<1.15.0' tensorflow-gpu==${TENSORFLOW_VERSION} keras h5py torch==${PYTORCH_VERSION} torchvision ${MXNET_URL}

# Install Open MPI
RUN wget https://www.open-mpi.org/software/ompi/v3.1/downloads/openmpi-3.1.2.tar.gz && \
    tar zxf openmpi-3.1.2.tar.gz && \
    cd openmpi-3.1.2 && \
    ./configure --enable-orterun-prefix-by-default && \
    make -j $(nproc) all && \
    make install && \
    ldconfig && \
    cd /root && \
    rm -rf openmpi-3.1.2.tar.gz openmpi-3.1.2

# Install Horovod, temporarily using CUDA stubs
RUN ldconfig /usr/local/cuda-9.0/targets/x86_64-linux/lib/stubs && \
    HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_WITH_TENSORFLOW=1 HOROVOD_WITH_PYTORCH=1 HOROVOD_WITH_MXNET=1 pip install --no-cache-dir horovod && \
    ldconfig

# Create a wrapper for OpenMPI to allow running as root by default
RUN mv /usr/local/bin/mpirun /usr/local/bin/mpirun.real && \
    echo '#!/bin/bash' > /usr/local/bin/mpirun && \
    echo 'mpirun.real --allow-run-as-root "$@"' >> /usr/local/bin/mpirun && \
    chmod a+x /usr/local/bin/mpirun

# Configure OpenMPI to run good defaults:
#   --bind-to none --map-by slot --mca btl_tcp_if_exclude lo,docker0
RUN echo "hwloc_base_binding_policy = none" >> /usr/local/etc/openmpi-mca-params.conf && \
    echo "rmaps_base_mapping_policy = slot" >> /usr/local/etc/openmpi-mca-params.conf && \
    echo "btl_tcp_if_exclude = lo,docker0" >> /usr/local/etc/openmpi-mca-params.conf

# Set default NCCL parameters
RUN echo NCCL_DEBUG=INFO >> /etc/nccl.conf

# Install OpenSSH for MPI to communicate between containers
RUN mkdir -p /var/run/sshd

# Allow OpenSSH to talk to containers without asking for confirmation
RUN cat /etc/ssh/ssh_config | grep -v StrictHostKeyChecking > /etc/ssh/ssh_config.new && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config.new && \
    mv /etc/ssh/ssh_config.new /etc/ssh/ssh_config

# Download examples
RUN svn checkout https://github.com/horovod/horovod/trunk/examples && \
    rm -rf /examples/.svn

# Install MOFED
RUN cd /root && \
    wget http://content.mellanox.com/ofed/${MOFED_SITE_PLACE}/${MOFED_IMAGE} && \
    tar -xzvf ${MOFED_IMAGE} && \
    ${MOFED_DIR}/mlnxofedinstall --user-space-only --without-fw-update --all -q && \
    cd /root && \
    rm -rf ${MOFED_DIR} && \
    rm -rf *.tgz

WORKDIR /root

