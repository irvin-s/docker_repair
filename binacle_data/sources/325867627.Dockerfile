# ==================================================================
# module list
# ------------------------------------------------------------------
# anaconda2
# python        2.7    (apt)
# pytorch 
# mpi4py
#

# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
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
        vim \
        openssh-server

# ==================================================================
# Anaconda2
# ------------------------------------------------------------------
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda2-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo "./opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrci  && \

# ==================================================================
# pytorch0.3.0  and mpi4py
# ------------------------------------------------------------------
    conda install -y pytorch=0.3.0 -c soumith && \
    conda install -y torchvision=0.1.8 && \
    conda install -y -c anaconda python-blosc && \
    conda install -y -c anaconda mpi4py && \
    conda install -y libgcc  && \


# ==================================================================
# hdmedian
# ==================================================================
    cd / && \
    apt-get install -y gcc && \
    git clone https://github.com/daleroberts/hdmedians.git && \
    cd hdmedians && \
    python setup.py install && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
