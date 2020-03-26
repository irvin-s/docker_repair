
FROM ubuntu:18.04

MAINTAINER lodemo

ARG TENSORFLOW_VERSION=1.0
ARG TENSORFLOW_ARCH=cpu
ARG OPENCV_VERSION=2.4.13.6


ENV TZ=Europe/London



RUN apt-get update

RUN apt-get update && apt-get install -y \
		tzdata


RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime
RUN rm /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata


RUN apt-get update && apt-get install -y \
		bc \
		build-essential \
		cmake \
		curl \
        pkg-config \
		g++ \
		gfortran \
		git \
        python2.7 \
        python-pip \
		libffi-dev \
		libfreetype6-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblcms2-dev \
		libopenblas-dev \
		liblapack-dev \
		libpng-dev \
		libssl-dev \
		libtiff5-dev \
		libwebp-dev \
		libzmq3-dev \
		nano \
		python-dev \
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
		python-tk \
        ffmpeg \
        && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*


# Custom compilation of OpenBLAS with OpenMP enabled 
# (linear algebra is limited to single core in debs)
# NUM_THREADS must be set otherwise docker hub build
# non-parallel version.
RUN git clone https://github.com/xianyi/OpenBLAS.git /tmp/OpenBLAS \
    && cd /tmp/OpenBLAS/ \
    && make DYNAMIC_ARCH=1 NO_AFFINITY=1 USE_OPENMP=1 NUM_THREADS=32 \
    && make DYNAMIC_ARCH=1 NO_AFFINITY=1 USE_OPENMP=1 NUM_THREADS=32 install \
    && rm -rf /tmp/OpenBLAS


# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
#RUN update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3
#RUN update-alternatives --list libblas.so.3 /usr/lib/atlas-base/atlas/libblas.so.3 /usr/lib/libblas/libblas.so.3 /usr/lib/openblas-base/libopenblas.so.0
RUN update-alternatives --install /usr/lib/libblas.so libblas.so /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/libblas.so.3 libblas.so.3 /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/liblapack.so liblapack.so /opt/OpenBLAS/lib/libopenblas.so 1000
RUN update-alternatives --install /usr/lib/liblapack.so.3 liblapack.so.3 /opt/OpenBLAS/lib/libopenblas.so 1000
RUN ldconfig

RUN apt-get update && apt-get install -y \
		python-nose \
		python-h5py \
		python-skimage \
        python-protobuf \
        python-openssl \
		python-mysqldb \
        && \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*


RUN pip --no-cache-dir install Pillow 

# Install TensorFlow
#RUN pip --no-cache-dir install \
#	https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_ARCH}/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl


# Install OpenCV
RUN cd /opt && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && \
    mkdir -p /opt/opencv-${OPENCV_VERSION}/build && \
    cd /opt/opencv-${OPENCV_VERSION}/build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D WITH_FFMPEG=ON \
    -D WITH_IPP=NO \
    -D WITH_OPENEXR=NO \
    -D WITH_TBB=YES \
    -D BUILD_EXAMPLES=NO \
    -D BUILD_ANDROID_EXAMPLES=NO \
    -D INSTALL_PYTHON_EXAMPLES=NO \
    -D BUILD_DOCS=NO \
    -D BUILD_opencv_python2=ON \
    -D BUILD_opencv_python3=NO \
    .. && \
    make VERBOSE=1 && \
    make -j${CPUCOUNT} && \
    make install && \
    rm -rf /opt/opencv-${OPENCV_VERSION}



WORKDIR /catana


COPY . /catana

RUN pip --no-cache-dir install -r requirements.txt

RUN pip --no-cache-dir install numpy -I


#RUN pip --no-cache-dir install -r ./src/face_recognition/facenet/requirements.txt
