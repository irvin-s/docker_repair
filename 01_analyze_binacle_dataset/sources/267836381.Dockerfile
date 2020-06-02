#
# Dockerfile for creating a docker image that runs the VGG Image Search Engine 
# (VISE).
#
# Author: Abhishek Dutta <adutta@robots.ox.ac.uk>
# Date: 04 July 2017
#

#
# Install Debian as base image (tightly controlled and minimal, 150 MB)
# See: https://hub.docker.com/_/debian/
#
FROM debian:jessie

#
# Define image labels
#
LABEL name="VGG Image Search Engine" codename="VISE" version="1.0.4" maintainer="Abhishek Dutta <adutta@robots.ox.ac.uk>" description="VGG Image Search Engine (VISE) enables image instance based search of a large collection of images."

#
# Define ports used by VISE
#   VISE trainer/loader : 9971
#   VISE loaded engine frontend : 9973
#
EXPOSE 9971 9973

VOLUME /opt/ox/vgg/vise/application_data/ /opt/ox/vgg/mydata/images/

#
# Define environment variables
#
ENV VGG_ROOT_DIR="/opt/ox/vgg/" VISE_ROOT_DIR="/opt/ox/vgg/vise/" VISE_CODE_DIR="/opt/ox/vgg/vise/vise-1.0.x/" VISE_DEP_DIR="/opt/ox/vgg/vise/build_deps/" VISE_DEP_LIBDIR="/opt/ox/vgg/vise/build_deps/lib/" VISE_DEP_SRCDIR="/opt/ox/vgg/vise/build_deps/tmp_libsrc/"

#
# Prepare environment variables
#
RUN mkdir -p $VGG_ROOT_DIR $VISE_ROOT_DIR $VISE_DEP_DIR $VISE_DEP_SRCDIR $VISE_DEP_LIBDIR

#
# Install VISE dependencies
# 
RUN apt-get update && apt-get install -y curl libpng12-dev libjpeg-dev cmake ssh openmpi-bin libopenmpi-dev python python-dev python-pip unzip libmagick++-dev libprotobuf-dev protobuf-compiler libboost-atomic-dev libboost-chrono-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libboost-timer-dev libcairo2 libcairo2-dev git && pip install cherrypy numpy pillow cython

#
# Compile dependencies (fastann, pypar, etc) and then compile VISE
#
RUN /bin/bash -c 'export FASTANN_LIBDIR=$VISE_DEP_LIBDIR"fastann/" ; \
 cd $VISE_DEP_SRCDIR ; \
 curl -o fastann.zip https://codeload.github.com/philbinj/fastann/zip/master ; \
 unzip fastann.zip ; \
 mv fastann-master fastann ; \
 cd fastann ; \
 mkdir build ; \
 cd build ; \
 export PREFIX=$FASTANN_LIBDIR ; \
 cmake ../ ; make -j8 ; make install; \
#
# Download VISE source
#
 cd $VISE_ROOT_DIR ; \
# curl -o vise-1.0.1.tar.gz https://gitlab.com/vgg/vise/raw/release/vise-1.0.1.tar.gz ; \
# tar -zxf vise-1.0.1.tar.gz ; cd vise-1.0.x ; mkdir build ; \
#
# uncomment the lines below if you wish to try out the latest master branch (may not be stable)
git clone -b master --single-branch https://gitlab.com/vgg/vise.git ; \
mv vise/ vise-1.0.x ; cd vise-1.0.x ; mkdir build ; \
#
#
# Compile pypar and dkmeans (needed for clustering)
#
 cd $VISE_CODE_DIR"src/external/dkmeans_relja/pypar_2.1.4_94/source" ; \
 python setup.py build ; python setup.py install ; \
 cd $VISE_CODE_DIR"src/external/dkmeans_relja/" ; \
 python setup.py build ; python setup.py install ; \
#
# Compile jpdraw (needed to draw regions and lines in search results)
#
 cd $VISE_CODE_DIR"src/external/jp_draw" ; \
 python setup.py build ; python setup.py install ; \
#
# Compile VISE
#
 cd $VISE_CODE_DIR"build/" ; \
 cmake -DCMAKE_PREFIX_PATH=$FASTANN_LIBDIR ../src ; \
 make -j8'

ENTRYPOINT $VISE_CODE_DIR"build/vise" $VISE_CODE_DIR /opt/ox/vgg/vise/application_data/ /opt/ox/vgg/mydata/images/
