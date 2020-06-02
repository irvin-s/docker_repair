FROM rsneddon/cudapythoncpu
#FROM kaixhin/cuda-caffe
MAINTAINER R Sneddon <581894@bah.com>
# install fast-rcnn's deps
# Get dependencies
RUN apt-get update && apt-get install -y \
    bc \
    cmake \
    curl \
    gcc-4.6 \
    g++-4.6 \
    gcc-4.6-multilib \
    g++-4.6-multilib \
    gfortran \
    git \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libboost-all-dev \
    libhdf5-serial-dev \
    liblmdb-dev \
    libjpeg62 \
    libfreeimage-dev \
    libatlas-base-dev \
    pkgconf \
    protobuf-compiler \
    python-dev \
    python-pip \
    unzip && \
    apt-get clean

# Use gcc 4.6
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-4.6 30 && \
    update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-4.6 30 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 30 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 30


RUN apt-get update && \
	apt-get install -y --force-yes git python-numpy cython python-pip python-skimage \
	python-protobuf python-opencv python-pandas python-yaml python-sklearn \
	octave python-ipdb

RUN	pip install --upgrade easydict

# octave is good enough for the PASCAL VOC stuff
RUN ln -s /usr/bin/octave /usr/bin/matlab

# build fast-rcnn
RUN cd /opt && \
	git clone --recursive https://github.com/rbgirshick/fast-rcnn.git

RUN	export CPLUS_INCLUDE_PATH=/opt/anaconda2/include && \
	export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/opt/anaconda2/include/python2.7  && \
	export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/opt/anaconda2/lib/python2.7/site-packages/numpy/core/include

ADD Makefile.config /opt/fast-rcnn/caffe-fast-rcnn/Makefile.config

# Install Glog and Gflags 
RUN cd /opt && \
    wget  --quiet --no-check-certificate http://pkgs.fedoraproject.org/lookaside/pkgs/glog/glog-0.3.3.tar.gz/a6fd2c22f8996846e34c763422717c18/glog-0.3.3.tar.gz && \
    tar zxvf glog-0.3.3.tar.gz && \
    cd glog-0.3.3 && \
    ./configure && \
    make -j$(nproc) && \
    make install -j$(nproc) && \
    cd .. && \
    rm -rf glog-0.3.3.tar.gz && \ 
    ldconfig && \
    cd /opt

RUN apt-get install -y unzip

RUN    wget --no-check-certificate --quiet https://github.com/schuhschuh/gflags/archive/master.zip && \
    unzip master.zip && \
    cd gflags-master && \
    mkdir build && \
    cd build && \
    export CXXFLAGS="-fPIC" && \
    cmake .. && \
    make VERBOSE=1 && \
    make  -j$(nproc) && \
    make install -j$(nproc) && \
    cd ../.. && \
    rm master.zip

# Install python dependencies
WORKDIR /opt
RUN    /opt/anaconda2/bin/conda install --yes conda==3.10.1 && \
    conda install --yes cython && \
    conda install --yes opencv && \
    conda install --yes --channel https://conda.binstar.org/auto easydict 

# To remove erro when loading libreadline from anaconda
RUN rm /opt/anaconda2/lib/libreadline* && \
    ldconfig 

WORKDIR /tmp
RUN wget --no-check-certificate https://sourceforge.net/projects/libpng/files/libpng15/older-releases/1.5.15/libpng-1.5.15.tar.gz
RUN tar -xvf libpng-1.5.15.tar.gz && \
    rm libpng-1.5.15.tar.gz
WORKDIR /tmp/libpng-1.5.15
RUN ./configure --prefix=/opt/libpng-1.5.15 && \
    make check -j$(nproc) && \
    make install -j$(nproc) && \
    make check -j$(nproc)

RUN	cd /opt/fast-rcnn/lib && make -j4
RUN	cd /opt/fast-rcnn/caffe-fast-rcnn && make -j4 && make -j4 pycaffe