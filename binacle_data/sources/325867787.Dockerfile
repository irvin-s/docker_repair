# This image contains all the libs and environment necessary for compiling and running Faster R-CNN
FROM 10.11.3.8:5000/nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
#FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-8.0/bin:$PATH
ENV LC_ALL=C

RUN	sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
	apt-get update && apt-get install -y --no-install-recommends \
		build-essential \
		cmake \
		git \
		wget \
		libatlas-base-dev \
		libboost-all-dev \
		libgflags-dev \
		libgoogle-glog-dev \
		libhdf5-serial-dev \
		libleveldb-dev \
		liblmdb-dev \
		libopencv-dev \
		libprotobuf-dev \
		libsnappy-dev \
		protobuf-compiler \
		python-dev \
		python-numpy \
		python-pip \
		python-setuptools \
		python-scipy \
		nano \
		libopenblas-dev \
		liblapack-dev \
		python-tk \
		openssh-client \
		openssh-server \
        autossh \
        expect && \
	apt-get install --no-install-recommends libboost-all-dev && \
	apt-get install libopenblas-dev \
		liblapack-dev \
		libatlas-base-dev \
		libgflags-dev \
		libgoogle-glog-dev \
		liblmdb-dev \
		gfortran && \
	apt-get install -y build-essential git \
		libprotobuf-dev \
		libleveldb-dev \
		libsnappy-dev \
		libopencv-dev \
		libboost-all-dev \
		libhdf5-serial-dev \
		libgflags-dev \
		libgoogle-glog-dev \
		liblmdb-dev \
		protobuf-compiler \
		protobuf-c-compiler \
		libyaml-dev \
		libffi-dev \
		libssl-dev \
		python-dev \
		python-pip \
		python3-pip \
		python3-tk \
		python-tk \
		liblmdb-dev \
		time \
		vim \
		screen \
		tmux

RUN	mkdir ~/.pip && echo "[global]" > ~/.pip/pip.conf && \
	echo "index-url=https://pypi.tuna.tsinghua.edu.cn/simple" >> ~/.pip/pip.conf && \
	echo "format = columns" >> ~/.pip/pip.conf

RUN	pip install --upgrade pip && pip3 install --upgrade pip

RUN	pip2 install scikit-image \
		Cython \
		numpy==1.15.2 \
		scipy \
		matplotlib==2.2.3 \
		ipython==5.6.0 \
		h5py \
		shapely \
		leveldb \
		networkx \
		nose \
		python-dateutil \
		pandas \
		protobuf \
		python-gflags \
		pyyaml \
		Pillow \
		six \
		decorator==4.3.0 \
		opencv-python \
		easydict \
		lmdb \
		sklearn \
		scikit-image \
		h5py \
		leveldb \
		imageio \
		cython \
		packaging \
		SimpleITK \
		pydicom \
		tqdm \
		cffi \
		tensorboardX \
		urllib3 \
		visdom \
		fire \
		git+https://github.com/pytorch/tnt.git@master \
		tqdm \
		ipdb \
		virtualenv \
		tensorflow-gpu==1.4.0 \
		tensorboard==1.11.0 \
		torch==0.4.0 \
		torchvision && \
	pip3 install tqdm \
		fire \
		SimpleITK \
		pydicom \
		lmdb \
		Cython \
		imageio \
		easydict \
		shapely \
		pandas \
		medicaltorch \
		jupyter \
		scikit-image \
		pillow \
		dominate requests \
		cffi \
		dlib \
		tensorflow-gpu==1.4.0 \
		tensorboard==1.11.0 \
		torch==0.4.1 torchvision \
		datetime \
		scipy \
		matplotlib \
		opencv-python
WORKDIR	/opt

RUN	git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl

WORKDIR /

