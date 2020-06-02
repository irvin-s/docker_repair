FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Chenglong Wu <wuchenglong15@gmail.com>

# Install some dependencies
RUN apt-get update && apt-get install -y \
	bc \
	build-essential \
	cmake \
	curl \
	g++ \
	net-tools \
	inetutils-ping \
	nginx \
	wget \
	curl \
	gfortran \
	git \
	libffi-dev \
	libfreetype6-dev \
	libhdf5-dev \
	libjpeg-dev \
	liblcms2-dev \
	libopenblas-dev \
	liblapack-dev \
	libpng12-dev \
	libssl-dev \
	libtiff5-dev \
	libwebp-dev \
	libzmq3-dev \
	nano \
	pkg-config \
	software-properties-common \
	unzip \
	vim \
	wget \
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
	openssh-server \
	ant \
	tmux \
	default-jdk \
	doxygen \
	&& \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    # Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
    update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
# Install Anaconda3
RUN curl -o /tmp/anaconda.sh https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.2.0-Linux-x86_64.sh && \
    chmod +x /tmp/anaconda.sh && \
    bash /tmp/anaconda.sh -b -p ~/anaconda3 && \ 
    rm /tmp/anaconda.sh && \
    echo 'export PATH="/root/anaconda3/bin:$PATH"' >> ~/.bashrc && \
    echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64"' >> ~/.bashrc && \
    . ~/.bashrc  && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main && \
    conda config --set show_channel_urls yes && \
	
    # pip install tensorflow-gpu:lastest, torch and others
    pip install shapely \
	msgpack \
	h5py==2.8.0 \
	pypng \ 
	sklearn \
	easydict \
	image \
        opencv-python==3.4.5.20 \
	&& \
    echo 'export PATH="/root/anaconda3/bin:$PATH"' >> /etc/profile && \
    echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:/usr/local/nvidia/lib64"' >> /etc/profile && \
    . /etc/profile && \
    conda install -y tensorflow-gpu==1.7.0 cudatoolkit==8.0 cudnn==7.0.5 && \	
    conda clean --all && \
    rm -r ~/.cache/pip/* 
