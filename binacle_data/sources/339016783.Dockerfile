FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu16.04

# CUDA includes
ENV CUDA_PATH /usr/local/cuda
ENV CUDA_INCLUDE_PATH /usr/local/cuda/include
ENV CUDA_LIBRARY_PATH /usr/local/cuda/lib64

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV CUDNN_VERSION 6.0.20
RUN apt-get update && apt-get install -y --allow-unauthenticated --no-install-recommends \
         build-essential \
         software-properties-common \
         apt-utils \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         libcudnn6=$CUDNN_VERSION-1+cuda8.0 \
         libcudnn6-dev=$CUDNN_VERSION-1+cuda8.0 && \
     rm -rf /var/lib/apt/lists/*

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-4.2.12-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install conda-build && \
     /opt/conda/bin/conda create -y --name pytorch-py35 python=3.5.2 numpy pyyaml scipy ipython mkl&& \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/envs/pytorch-py35/bin:$PATH
RUN conda update conda
RUN conda install --name pytorch-py35 -c pytorch pytorch torchvision cuda80

RUN pip install gym==0.9.2
RUN pip install gym[atari]

# Sacred and other required packages
RUN pip install sacred GitPython

# Section to get permissions right, and avoid running inside as root {{
    # Create a user matching the UID, and create/chmod home dir (== project directory)
    # (uid corresponds to breord in CS network)
    RUN useradd -d /project -u <<UID>> --create-home user
    USER user
    WORKDIR /project/
    ADD . /project/

ENV PYTHONPATH "$PYTHONPATH:/project/"
# }}

RUN mkdir ./results
RUN chmod -R a+w ./results
