FROM ubuntu:16.04
MAINTAINER Gist Noesis <gistnoeis@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's#http://archive.ubuntu.com/#http://fr.archive.ubuntu.com/#' /etc/apt/sources.list

# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl \
     && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor \
        openssh-server pwgen sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        libreoffice firefox \
        fonts-wqy-microhei \
        language-pack-zh-hant language-pack-gnome-zh-hant firefox-locale-zh-hant libreoffice-l10n-zh-tw \
        nginx \
        python-pip python-dev build-essential \
        mesa-utils libgl1-mesa-dri \
        gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine pinta  \
        dbus-x11 x11-utils 

RUN \
  echo "deb http://archive.ubuntu.com/ubuntu/ xenial universe multiverse" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade

# install some basic utilities
RUN \
  apt-get install -y build-essential && \
  apt-get install -y curl git htop man unzip wget nano

# tini for subreap                                   
ENV TINI_VERSION v0.9.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

RUN apt-get install -y v4l-utils ffmpeg

# bluez dependencies
RUN \
  apt-get install -y libglib2.0-dev libical-dev libreadline-dev libudev-dev libdbus-1-dev libdbus-glib-1-dev

# debugging
RUN \
  apt-get install -y usbutils strace

RUN \
  apt-get install -y bluez bluez-hcidump blueman checkinstall libusb-dev libbluetooth-dev joystick

RUN wget http://www.pabr.org/sixlinux/sixpair.c
RUN gcc -o sixpair sixpair.c -lusb

RUN \
  git clone https://github.com/aaronp24/QtSixA.git \
	&& cd QtSixA/sixad && make && sudo mkdir -p /var/lib/sixad/profiles && sudo checkinstall -y

 RUN \
  apt-get install -y python-dbus


#install opencv3 python 3
RUN apt-get -y install wget unzip \
 build-essential cmake git pkg-config libatlas-base-dev gfortran \
 libjasper-dev libgtk2.0-dev libavcodec-dev libavformat-dev \ 
libswscale-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libv4l-dev 

RUN sudo apt-get install -y python3-pip
RUN pip3 install numpy

RUN wget https://github.com/Itseez/opencv/archive/3.3.0.zip 
RUN unzip 3.3.0.zip 
RUN mv opencv-3.3.0 /opencv 
RUN mkdir /opencv/release
WORKDIR /opencv/release 
RUN cmake -DBUILD_TIFF=ON \ 
-DBUILD_opencv_java=OFF \
-DWITH_CUDA=OFF \
-DENABLE_AVX=ON \
-DWITH_OPENGL=ON \
-DWITH_OPENCL=ON \
-DWITH_IPP=OFF \
-DWITH_TBB=ON \
-DWITH_EIGEN=ON \
-DWITH_V4L=ON \
-DWITH_VTK=OFF \
-DBUILD_TESTS=OFF \
-DBUILD_PERF_TESTS=OFF \
-DCMAKE_BUILD_TYPE=RELEASE \
-DBUILD_opencv_python2=OFF \
-DCMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
-DPYTHON3_EXECUTABLE=$(which python3) \
-DPYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-DPYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") ..
RUN make -j4 
RUN make install

RUN apt-get install -y ipython3

RUN pip3 install scipy pyserial evdev zmq

ADD image /
RUN pip install setuptools wheel && pip install -r /usr/lib/web/requirements.txt



RUN useradd -ms /bin/bash linn
RUN usermod -a -G audio linn

#currently we always build against latest but we 'll probably fix the version to increase stability in the future
RUN git clone https://github.com/GistNoesis/Linn-Photobooth.git /root/Linn-Photobooth



EXPOSE 80
WORKDIR /root



ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
ENTRYPOINT ["/startup.sh"]