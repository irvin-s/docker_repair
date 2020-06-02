FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

ENV LD_LIBRARY_PATH /usr/lib/x86_64-linux-gnu:/usr/local/cuda-9.0/lib64:$LD_LIBRARY_PATH
ENV PATH /opt/conda/bin:$PATH

# set a customizable and preservable ".bashrc" if necessary 
RUN sed -i '$a if [ -f /userhome/root/.bashrc ]; then\n  . /userhome/root/.bashrc\nfi' /root/.bashrc

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    apt-get update && \
    $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        openssh-client \
        openssh-server \
        unzip \
        && \
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

RUN wget --quiet https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh -O ~/conda.sh && \
    /bin/bash ~/conda.sh -b -p /opt/conda && \
    rm ~/conda.sh

RUN conda config --set show_channel_urls yes && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ 

RUN conda install -y numpy matplotlib scikit-image pillow opencv cython && \
    conda clean -y --all

RUN pip install --upgrade pip && \
    pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple torch && \
    pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple torchvision && \
    pip --no-cache-dir install -i https://pypi.tuna.tsinghua.edu.cn/simple tensorflow-gpu


EXPOSE 6006
WORKDIR /userhome
