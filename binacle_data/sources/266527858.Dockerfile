FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2-RC
#FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2-RC

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com

ENV ARCH=arm64
ARG URL=http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/3.2/pwv346/JetPackL4T_32_b157

# Download libopencv4tegra (186 denotes TX2 soc chip)
RUN curl -sL $URL/libopencv_3.3.1_t186_arm64.deb -so /tmp/libopencv_arm64.deb
RUN curl -sL $URL/libopencv-dev_3.3.1_t186_arm64.deb -so /tmp/libopencv-dev_arm64.deb
RUN curl -sL $URL/libopencv-python_3.3.1_t186_arm64.deb -so /tmp/libopencv-python_arm64.deb

# Install dependencies
RUN apt-get install -y pkg-config libavcodec-ffmpeg56 libavformat-ffmpeg56 libswscale-ffmpeg3 libtbb2 libcairo2 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk2.0-0 libjasper1 libjpeg8 libtbb-dev

# Install libopencv4tegra
#RUN dpkg -i /tmp/libopencv4tegra-repo_2.4.13-17-g5317135_arm64_l4t-r24.deb
RUN dpkg -i /tmp/libopencv_arm64.deb && dpkg -i /tmp/libopencv-dev_arm64.deb && dpkg -i /tmp/libopencv-python_arm64.deb

# Install additional packages
RUN apt-get update && apt-get install -y --no-install-recommends --allow-unauthenticated build-essential cmake git gfortran libatlas-base-dev libboost-all-dev libgflags-dev libfreetype6-dev libpng12-dev libgoogle-glog-dev libhdf5-serial-dev libleveldb-dev liblmdb-dev libprotobuf-dev libsnappy-dev protobuf-compiler python-all-dev python-dev python-pip

# Pip for python stuff
RUN pip install --upgrade --no-cache-dir pip setuptools wheel
RUN pip install --no-cache-dir numpy
RUN pip install --no-cache-dir pillow matplotlib h5py protobuf scipy scikit-image scikit-learn

WORKDIR /
RUN git clone https://github.com/BVLC/caffe
WORKDIR /caffe
RUN apt-get install -y python-setuptools
WORKDIR /caffe/python
RUN for req in $(cat requirements.txt); do pip install --no-cache-dir $req; done
WORKDIR /caffe
RUN cp Makefile.config.example Makefile.config

# Prep make with correct Python include dirs
RUN sed -i "s/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include/INCLUDE_DIRS := \$(PYTHON_INCLUDE) \/usr\/local\/include \/usr\/local\/lib\/python2.7\/dist-packages\/numpy\/core\/include \/usr\/include\/hdf5\/serial/g" Makefile.config
RUN sed -i "s/# USE_CUDNN := 1/USE_CUDNN := 1/g" Makefile.config
# CUDA9.0 update: Comment out "compute_20" lines in makefile.config (this arch obsolete)
RUN sed -i "s/-gencode arch=compute_20,code=sm_20/#-gencode arch=compute_20,code=sm_20/g" Makefile.config
RUN sed -i "s/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_hl hdf5/LIBRARIES += glog gflags protobuf boost_system boost_filesystem m hdf5_serial_hl hdf5_serial opencv_core opencv_highgui opencv_imgproc opencv_imgcodecs/g" Makefile

# Build
RUN ldconfig
RUN make all -j4
RUN make pycaffe -j4
RUN make test -j4
RUN make distribute

# Clean up
RUN apt-get -y autoremove && apt-get -y autoclean
