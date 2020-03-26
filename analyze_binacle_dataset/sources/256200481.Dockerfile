# Modified from h\ttps://github.com/saiprashanths/dl-docker
FROM nvidia/cuda:7.5-cudnn5-devel

MAINTAINER Brian Lee Yung Rowe <rowe@zatonovo.com>

ARG THEANO_VERSION=rel-0.8.2
ARG KERAS_VERSION=1.1.0
ARG TORCH_VERSION=latest

# Install some dependencies
RUN apt-get update && apt-get install -y \
    curl wget git \
    nano vim \
    bc \
    build-essential \
    pkg-config software-properties-common \
    cmake g++ gfortran \
    libopenblas-dev liblapack-dev \
    libffi-dev libfreetype6-dev libhdf5-dev liblcms2-dev \
    libjpeg-dev libopenjpeg2 libpng12-dev libtiff5-dev \
    libssl-dev \
    libwebp-dev libzmq3-dev \
    python-dev \
    zlib1g-dev unzip \
    && \
  apt-get clean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/* && \
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
  update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3

# Install latest version of pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
  python get-pip.py && \
  rm get-pip.py


# Add SNI support to Python
RUN pip --no-cache-dir install pyopenssl ndg-httpsclient pyasn1

# Install useful Python packages using apt-get to avoid version incompatibilities with Tensorflow binary
# especially numpy, scipy, skimage and sklearn (see https://github.com/tensorflow/tensorflow/issues/2034)
RUN apt-get update && apt-get install -y \
    python-numpy \
    python-scipy \
    python-nose \
    python-h5py \
    python-skimage \
    python-matplotlib \
    python-pandas \
    python-sklearn \
    python-sympy \
    && \
  apt-get clean && \
  apt-get autoremove && \
  rm -rf /var/lib/apt/lists/*

# Install other useful Python packages using pip
RUN pip --no-cache-dir install --upgrade ipython && \
  pip --no-cache-dir install \
    Cython \
    ipykernel \
    jupyter \
    path.py \
    Pillow \
    pygments \
    six \
    sphinx \
    wheel \
    zmq \
    && \
  python -m ipykernel.kernelspec


# Install Theano and set up Theano config (.theanorc) for CUDA and OpenBLAS
RUN pip --no-cache-dir install git+git://github.com/Theano/Theano.git@${THEANO_VERSION} && \
  \
  echo "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\nmode=FAST_RUN \
    \n[lib]\ncnmem=0.95 \
    \n[nvcc]\nfastmath=True \
    \n[blas]\nldflag = -L/usr/lib/openblas-base -lopenblas \
    \n[DebugMode]\ncheck_finite=1" \
  > /root/.theanorc


# Install Keras
RUN pip --no-cache-dir install git+git://github.com/fchollet/keras.git@${KERAS_VERSION}


# Install Torch
RUN git clone https://github.com/torch/distro.git /root/torch --recursive && \
  cd /root/torch && \
  bash install-deps && \
  yes no | ./install.sh

# Export the LUA evironment variables manually
ENV LUA_PATH='/root/.luarocks/share/lua/5.1/?.lua;/root/.luarocks/share/lua/5.1/?/init.lua;/root/torch/install/share/lua/5.1/?.lua;/root/torch/install/share/lua/5.1/?/init.lua;./?.lua;/root/torch/install/share/luajit-2.1.0-beta1/?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua' \
  LUA_CPATH='/root/.luarocks/lib/lua/5.1/?.so;/root/torch/install/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so' \
  PATH=/root/torch/install/bin:$PATH \
  LD_LIBRARY_PATH=/root/torch/install/lib:$LD_LIBRARY_PATH \
  DYLD_LIBRARY_PATH=/root/torch/install/lib:$DYLD_LIBRARY_PATH
ENV LUA_CPATH='/root/torch/install/lib/?.so;'$LUA_CPATH

# Install the latest versions of nn, cutorch, cunn, cuDNN bindings and iTorch
RUN luarocks install nn && \
  luarocks install cutorch && \
  luarocks install cunn && \
  luarocks install dp && \
  luarocks install mnist && \
  luarocks install qtlua && \
  \
  cd /root && git clone https://github.com/soumith/cudnn.torch.git && cd cudnn.torch && \
  git checkout R4 && \
  luarocks make && \
  \
  cd /root && git clone https://github.com/facebook/iTorch.git && \
  cd iTorch && \
  luarocks make
RUN wget https://raw.githubusercontent.com/rtsisyk/luafun/master/fun-scm-1.rockspec && luarocks install fun-scm-1.rockspec



# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

# Use theano backend
COPY keras.json /root/.keras/

# Expose Ports for IPython (8888)
EXPOSE 8888

WORKDIR "/code"
CMD ["/bin/bash"]
