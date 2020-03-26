# A Docker image to be used for building the sample applications for the Linux SDK Ubuntu 16.04
#
# build:
# $ docker build --file=Dockerfile-Ubuntu --tag=v4.0.0:affdex .
#
# the result will be an image that has the tar'ed artifact of the sample app and all of its dependencies installed
#
# run interactively:
# $ docker run -it --rm v4.0.0:affdex

FROM ubuntu:16.04

# Get dependencies
RUN apt-get update && apt-get install -y software-properties-common
# Repo for latest git 2.x
RUN add-apt-repository -y ppa:git-core/ppa && apt-get update && apt-get install -y git

RUN apt-get update && apt-get install -y \
                  libcurl4-openssl-dev \
                  libssl-dev \
                  bc \
                  gfortran \
                  unzip \
                  wget \
                  g++ \
                  make \
                  libopencv-dev

ENV SRC_DIR /opt/src
ENV BUILD_DIR /opt/build
ENV ARTIFACT_DIR /opt/testapp-artifact

#################################
###### Clone Sample App Repo ######
#################################

RUN git clone https://github.com/Affectiva/cpp-sdk-samples.git $SRC_DIR/sdk-samples

#### CMAKE ####
WORKDIR $SRC_DIR
RUN wget https://cmake.org/files/v3.8/cmake-3.8.1.tar.gz \
    && tar -xf cmake-3.8.1.tar.gz && rm cmake-3.8.1.tar.gz
RUN cd $SRC_DIR/cmake-3.8.1/ && \
    ./bootstrap --system-curl && \
    make -j$(nproc) install > /dev/null && \
    rm -rf $SRC_DIR/cmake-3.8.1

#### BOOST ####
WORKDIR $SRC_DIR
RUN wget https://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz --no-check-certificate && \
    tar -xf boost_1_63_0.tar.gz && \
    rm boost_1_63_0.tar.gz && \
    cd $SRC_DIR/boost_1_63_0 && \
    ./bootstrap.sh &&\
    ./b2 -j $(nproc) cxxflags=-fPIC threading=multi runtime-link=shared \
         --with-log --with-serialization --with-system --with-date_time \
         --with-filesystem --with-regex --with-timer --with-chrono --with-thread \
         --with-program_options \
         install && \
    rm -rf $SRC_DIR/boost_1_63_0

#### DOWNLOAD Affdex Ubuntu SDK ####
WORKDIR $SRC_DIR
RUN wget https://download.affectiva.com/linux/gcc-5.4/affdex-cpp-sdk-4.0-75-ubuntu-xenial-xerus-x86_64bit.tar.gz &&\
    mkdir -p affdex-sdk && \
    tar -xf affdex-cpp* -C affdex-sdk && \
    rm -r $SRC_DIR/affdex-cpp-sdk-*

#### BUILD SAMPLE APP ####
RUN mkdir -p $BUILD_DIR &&\
    cd $BUILD_DIR &&\
    cmake -DOpenCV_DIR=/usr/ -DBOOST_ROOT=/usr/ -DAFFDEX_DIR=$SRC_DIR/affdex-sdk $SRC_DIR/sdk-samples &&\
    make -j$(nproc) > /dev/null

## CREATE THE ARTIFACT
WORKDIR $ARTIFACT_DIR
RUN mkdir -p $ARTIFACT_DIR &&\
    mv $SRC_DIR/affdex-sdk/ . &&\
    mv $BUILD_DIR . &&\
    tar -cvf ../testapp-artifact.tar.gz .

ENV AFFDEX_DATA_DIR $ARTIFACT_DIR/affdex-sdk/data
ENV LD_LIBRARY_PATH $ARTIFACT_DIR/affdex-sdk/lib
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4

WORKDIR /opt
