# Version 1.0.2
FROM ubuntu:14.04
#MAINTAINER José Augusto Paiva "zepspaiva@gmail.com"
#MAINTAINER NVIDIA CORPORATION <digits@nvidia.com>
MAINTAINER Enrique Otero "enrique.otero@beeva.com"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN sudo apt-get -y install \
	git \
	build-essential \
	cmake \
	wget \
	curl

RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; ./install.sh
RUN /bin/bash -c "source ~/.bashrc"

ENV PATH="$PATH:/root/torch/install/bin"

RUN luarocks install nn
RUN luarocks install nngraph
RUN luarocks install image


ENV NVIDIA_GPGKEY_SUM bd841d59a27a406e513db7d405550894188a4c1cd96bf8aa4f82f1b39e0b5c1c
ENV NVIDIA_GPGKEY_FPR 889bee522da690103c4b085ed88c3d385c37d3be

RUN apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/GPGKEY && \
    apt-key adv --export --no-emit-version -a $NVIDIA_GPGKEY_FPR | tail -n +2 > cudasign.pub && \
    echo "$NVIDIA_GPGKEY_SUM cudasign.pub" | sha256sum -c --strict - && rm cudasign.pub && \
    echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64 /" > /etc/apt/sources.list.d/cuda.list

ENV CUDA_VERSION 7.5
LABEL com.nvidia.cuda.version="7.5"

ENV CUDA_PKG_VERSION 7-5=7.5-18
RUN apt-get update && apt-get install -y --no-install-recommends --force-yes \
        cuda-nvrtc-$CUDA_PKG_VERSION \
        cuda-cusolver-$CUDA_PKG_VERSION \
        cuda-cublas-$CUDA_PKG_VERSION \
        cuda-cufft-$CUDA_PKG_VERSION \
        cuda-curand-$CUDA_PKG_VERSION \
        cuda-cusparse-$CUDA_PKG_VERSION \
        cuda-npp-$CUDA_PKG_VERSION \
        cuda-cudart-$CUDA_PKG_VERSION && \
    ln -s cuda-$CUDA_VERSION /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

RUN echo "/usr/local/cuda/lib" >> /etc/ld.so.conf.d/cuda.conf && \
    echo "/usr/local/cuda/lib64" >> /etc/ld.so.conf.d/cuda.conf && \
    ldconfig

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}


RUN luarocks install cutorch
RUN luarocks install cunn

# Only for training
RUN apt-get -y install libprotobuf-dev protobuf-compiler
RUN luarocks install loadcaffe

RUN apt-get -y install libhdf5-dev hdf5-tools python-dev python-pip
RUN pip install cython numpy h5py
RUN luarocks install hdf5

WORKDIR /home
RUN git clone https://github.com/karpathy/neuraltalk2
WORKDIR /home/neuraltalk2

RUN wget http://cs.stanford.edu/people/karpathy/neuraltalk2/checkpoint_v1_cpu.zip
RUN unzip checkpoint_v1_cpu.zip

WORKDIR /home/neuraltalk2/vis
RUN python -m SimpleHTTPServer
