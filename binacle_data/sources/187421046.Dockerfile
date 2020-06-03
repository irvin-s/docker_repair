# A Docker image to be used for building the sample applications for the Linux SDK CentOS7
#
# build:
# $ docker build --file=Dockerfile-CentOS --tag=v4.0.0:affdex .
#
# the result will be an image that has the tar'ed artifact of the sample app and all of its dependencies installed
#
# run interactively:
# $ docker run -it --rm v4.0.0:affdex

FROM affectiva/centos7-updates
MAINTAINER Affectiva Development (affdexdev@affectiva.com)

# Repo for latest git 2.x
RUN yum remove -y git
RUN yum install -y http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm

RUN yum install -y gcc \
                   gcc-c++ \
                   jhead \
                   curl-devel \
                   openssl-devel \
                   zlib-devel \
                   wget \
                   git \
                   opencv-devel \
                   make

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
    make -j$(nproc) && \
    make install && \
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
         --with-program_options install && \
    rm -rf $SRC_DIR/boost_1_63_0

#### DOWNLOAD Affdex CentOS SDK ####
WORKDIR $SRC_DIR
RUN wget https://download.affectiva.com/linux/centos-4.8/affdex-cpp-sdk-4.0-2941-centos-7-x86_64bit.tar.gz &&\
    mkdir -p affdex-sdk && \
    tar -xf affdex-cpp* -C affdex-sdk && \
    rm -r $SRC_DIR/affdex-cpp-sdk-4.0-2941-centos-7-x86_64bit.tar.gz

#### BUILD SAMPLE APP ####
RUN mkdir -p $BUILD_DIR &&\
    cd $BUILD_DIR &&\
    cmake -DOpenCV_DIR=/usr/ -DBOOST_ROOT=/usr/ -DAFFDEX_DIR=$SRC_DIR/affdex-sdk $SRC_DIR/sdk-samples &&\
    make -j$(nproc)

## CREATE THE ARTIFACT
WORKDIR $ARTIFACT_DIR
RUN mkdir -p $ARTIFACT_DIR &&\
    mv $SRC_DIR/affdex-sdk/ . &&\
    mv $BUILD_DIR . &&\
    tar -cvf ../testapp-artifact.tar.gz .

ENV AFFDEX_DATA_DIR $ARTIFACT_DIR/affdex-sdk/data
ENV LD_LIBRARY_PATH $ARTIFACT_DIR/affdex-sdk/lib
ENV LD_PRELOAD /usr/lib64/libopencv_core.so

WORKDIR /opt
