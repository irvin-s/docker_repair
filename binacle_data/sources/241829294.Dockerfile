#FROM ubuntu:16.04
# FROM jfinmetrix/rhadley_ubuntu
FROM ubuntu:trusty
#FROM debian:stretch

MAINTAINER Shlomo <shlomo@deep-ml.com>

#ENV LLVM_CONFIG /usr/local/opt/llvm/bin/llvm-config
#ENV LLVM_CONFIG=/usr/lib/llvm-3.8/bin/llvm-config

ARG DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive


#Install base dependencies
RUN apt-get update && apt-get install -y git wget cmake build-essential libgoogle-glog-dev libgflags-dev libeigen3-dev libopencv-dev libcppnetlib-dev libboost-dev libboost-iostreams-dev libcurlpp-dev libcurl4-openssl-dev protobuf-compiler libopenblas-dev libhdf5-dev libprotobuf-dev libleveldb-dev libsnappy-dev liblmdb-dev libutfcpp-dev wget liblapack-dev fortran-compiler  libedit-dev

RUN apt-get update


# Very complicated step, took me hours to make it works. this is required for fastparquet

RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty main \n\
deb-src http://llvm.org/apt/trusty/ llvm-toolchain-trusty main \n\
deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main \n\
deb-src http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" >> /etc/apt/sources.list

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update && apt-get install -y clang-3.7 libclang-common-3.7-dev libclang-3.7-dev libclang1-3.7  libllvm-3.7-ocaml-dev libllvm3.7 lldb-3.7 llvm-3.7 llvm-3.7-dev llvm-3.7-runtime clang-modernize-3.7 clang-format-3.7 lldb-3.7-dev
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "/usr/lib/llvm-3.7/lib/" >> /etc/ld.so.conf && ldconfig


ENV LD_LIBRARY_PATH /usr/lib/llvm-3.7/lib/
ENV LLVM_CONFIG /usr/lib/llvm-3.7/bin/llvm-config

RUN sudo apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install python 3
    build-essential \
    clang-3.7 \
    lldb-3.7 \
    llvm-3.7 \
    python-clang-3.7 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


#Install dependencies
RUN apt-get update && apt-get install --no-install-recommends  -y \
        # install essentials
        build-essential \
        software-properties-common \
        g++ \
        git \
        wget \
        tar \
        git \
        imagemagick \
        curl \
		bc \
		htop\
		cmake \
		curl \
		g++ \
		gfortran \
		git \
		libffi-dev \
		libfreetype6-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblcms2-dev \
		libopenblas-dev \
		liblapack-dev \
		libssl-dev \
		libtiff5-dev \
		libwebp-dev \
		libzmq3-dev \
		nano \
		unzip \
		vim \
		zlib1g-dev \
		qt5-default \
		libvtk6-dev \
		zlib1g-dev \
		libjpeg-dev \
		libwebp-dev \
		libpng-dev \
		libtiff5-dev \
		libjasper-dev \
		libopenexr-dev \
		libgdal-dev \
		libdc1394-22-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
		libtheora-dev \
		libvorbis-dev \
		libxvidcore-dev \
		libx264-dev \
		yasm \
		libopencore-amrnb-dev \
		libopencore-amrwb-dev \
		libv4l-dev \
		libxine2-dev \
		libtbb-dev \
		libeigen3-dev \
		doxygen \
		less \
        htop \
        procps \
        vim-tiny \
        libboost-dev \
        libgraphviz-dev \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3


####################################################PYTHON2########################################################
# install debian packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install python 2
    python \
    python-dev \
    python-pip \
    python-setuptools \
    python-virtualenv \
    python-wheel \
	python-tk \
    pkg-config \
    # requirements for numpy
    libopenblas-base \
    python-numpy \
    python-scipy \
    # requirements for keras
    python-h5py \
    python-yaml \
    python-pydot \
    python-nose \
	python-h5py \
	python-skimage \
	python-matplotlib \
	python-pandas \
	python-sklearn \
	python-sympy \
	ipython \
	python-joblib \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install pip
RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
	python get-pip.py && \
	rm get-pip.py

#RUN python -m pip install --upgrade --force pip
RUN pip install pip --upgrade
RUN pip install pyOpenSSL ndg-httpsclient pyasn1



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


ENV LD_LIBRARY_PATH /usr/lib/llvm-3.7/lib/
ENV LLVM_CONFIG /usr/lib/llvm-3.7/bin/llvm-config


RUN pip --no-cache-dir install  cython pytest pandas scikit-learn statsmodels line-profiler psutil spectrum memory_profiler pandas ipython[all] jupyter joblib pyparsing pydot pydot-ng graphviz pandoc SQLAlchemy flask toolz cloudpickle python-snappy s3fs widgetsnbextension ipywidgets terminado cytoolz bcolz blosc partd backports.lzma mock cachey moto pandas_datareader


RUN pip install -i https://pypi.anaconda.org/sklam/simple llvmlite

#RUN pip install llvmlite

# Distributed dataframes
RUN pip --no-cache-dir install numba
RUN pip --no-cache-dir install git+https://github.com/dask/dask.git
RUN pip --no-cache-dir install git+https://github.com/dask/distributed.git

RUN pip --no-cache-dir install fastparquet

#please point LLVM_CONFIG to the path for llvm-config

#RUN pip --no-cache-dir install  llvmpy

# Install Theano and set up Theano config (.theanorc) OpenBLAS
RUN pip --no-cache-dir install theano && \
	\
	echo "[global]\ndevice=cpu\nfloatX=float32\nmode=FAST_RUN \
		\n[lib]\ncnmem=0.95 \
		\n[nvcc]\nfastmath=True \
		\n[blas]\nldflag = -L/usr/lib/openblas-base -lopenblas \
		\n[DebugMode]\ncheck_finite=1" \
	> /root/.theanorc


ARG TENSORFLOW_VERSION=0.11.0
ARG TENSORFLOW_DEVICE=cpu
ARG TENSORFLOW_APPEND=
RUN pip --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_DEVICE}/tensorflow${TENSORFLOW_APPEND}-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl

ARG KERAS_VERSION=1.2.2
ENV KERAS_BACKEND=tensorflow
RUN pip --no-cache-dir install --no-dependencies git+https://github.com/fchollet/keras.git@${KERAS_VERSION}


# Install BAYESIAN FRAMEWORKS
RUN pip --no-cache-dir install  --upgrade pymc3 pystan edward watermark xgboost bokeh seaborn mmh3


# dump package lists
RUN dpkg-query -l > /dpkg-query-l.txt \
 && pip2 freeze > /pip2-freeze.txt

####################################################PYTHON2########################################################


# configure console
RUN echo 'alias ll="ls --color=auto -lA"' >> /root/.bashrc \
 && echo '"\e[5~": history-search-backward' >> /root/.inputrc \
 && echo '"\e[6~": history-search-forward' >> /root/.inputrc
# default password: keras
ENV PASSWD='sha1:98b767162d34:8da1bc3c75a0f29145769edc977375a373407824'


# dump package lists
RUN dpkg-query -l > /dpkg-query-l.txt \
 && pip3 freeze > /pip3-freeze.txt


RUN git clone https://github.com/dask/dask-tutorial.git ./dask-tutorial
RUN git clone https://github.com/dask/dask-examples.git ./dask-examples

# Set up notebook config
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Expose Ports for TensorBoard (6006), Ipython (8888) drill
EXPOSE 6006 3838 8787 8888 8786 9786 8788

WORKDIR "/root"

RUN git clone https://github.com/dask/dask-tutorial.git ./dask-tutorial
RUN git clone https://github.com/dask/dask-examples.git ./dask-examples


RUN git clone https://github.com/vgvassilev/cling.git   ./cling
RUN conda install libgcc
RUN export PATH=/root/cling/bin:$PATH
RUN cd /root/cling/tools/Jupyter/kernel
RUN pip install -e .

RUN ./jupyter-kernelspec install --user cling-c++11

RUN pwd
RUN df -k
RUN chmod +x run_jupyter.sh
RUN ls -la

##RUN ./run_jupyter.sh

#CMD daskd-scheduler &

#CMD ["/bin/bash", "-c", "./run_jupyter.sh"]
