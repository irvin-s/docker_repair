# Start with Ubuntu base image
FROM ubuntu:15.04
MAINTAINER Patrick Callier <pcallier@lab41.org>

ENV DEBIAN_FRONTEND noninteractive

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget

# Use .deb method to install CUDA 7.5 + NVidia drivers (352.79)
RUN cd /tmp && \
    wget -q http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1504/x86_64/cuda-repo-ubuntu1504_7.5-18_amd64.deb && \
    dpkg -i cuda-repo-ubuntu1504_7.5-18_amd64.deb && \
    apt-get update && \
    apt-get install -y cuda


# Install cuDNN v4
ADD cudnn-7.0-linux-x64-v4.0-rc.tgz /opt/

# Install git, python-dev, pip and other dependencies
RUN apt-get update && apt-get install -y \
  git \
  libopenblas-dev \
  python-dev \
  python-pip \
  python-nose \
  python-numpy \
  python-scipy

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin
# Install bleeding-edge Theano
RUN pip install --upgrade --no-deps git+git://github.com/Theano/Theano.git
# Set up .theanorc for CUDA, theanorc in work directory takes precedence
ENV THEANORC="/root/.theanorc:/work/.theanorc"
RUN echo "[global]\ndevice=gpu\nfloatX=float32\n[lib]\ncnmem=0\n[nvcc]\nfastmath=True" > /root/.theanorc

RUN apt-get update && apt-get install -y \
  libhdf5-dev \
  python-h5py \
  python-yaml

# Upgrade six
RUN pip install --upgrade six && \
    cd /root && git clone https://github.com/fchollet/keras.git && cd keras && \
    python setup.py install && \
    apt-get -y install vim

RUN pip install jupyter && \
    apt-get -y build-dep python-matplotlib
RUN pip install matplotlib seaborn bokeh pandas scikit-learn scikit-image
RUN cd /root && \
    wget https://pypi.python.org/packages/source/t/tornado/tornado-4.1.tar.gz && \
    gunzip tornado-4.1.tar.gz && tar -xvf tornado-4.1.tar && \
    cd tornado-4.1 && python setup.py install && \
    pip install notebook 

# Startup script
RUN printf '#!/bin/bash\n\njupyter notebook --no-browser --ip="*"' > /bootstrap.sh && \
    chmod +x /bootstrap.sh

# Add CUDA, cuDNN to path
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:/opt/cuda/lib64:$LD_LIBRARY_PATH
ENV LIBRARY_PATH=/opt/cuda/lib64:$LIBRARY_PATH
ENV CPATH=/opt/cuda/include:$CPATH

EXPOSE 8888


CMD ["/bootstrap.sh"]
