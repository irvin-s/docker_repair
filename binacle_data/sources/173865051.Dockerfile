# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.15

MAINTAINER m.maatkamp@gmail.com version: 0.1

RUN apt-get update && apt-get dist-upgrade -yf && apt-get clean && apt-get autoremove
RUN apt-get install -y git subversion axel wget zip unzip \
cmake build-essential git-core cmake g++ python-dev swig pkg-config \
libfftw3-dev libboost1.55-all-dev libcppunit-dev libgsl0-dev libusb-dev \
libsdl1.2-dev python-wxgtk2.8 python-numpy python-cheetah python-lxml doxygen \
libxi-dev python-sip libqt4-opengl-dev libqwt-dev libfontconfig1-dev \
libxrender-dev python-sip python-sip-dev libusb-1.0

# --- 
# GNURadio 

RUN mkdir /gnuradio
WORKDIR /gnuradio

RUN axel http://www.sbrac.org/files/build-gnuradio && chmod a+x ./build-gnuradio && printf "y\ny\ny\ny\n" | ./build-gnuradio -ja -e all -o
RUN echo "export PYTHONPATH=/usr/local/lib/python2.7/dist-packages" > ~/.bashrc

ENTRYPOINT      ["/bin/bash"]
