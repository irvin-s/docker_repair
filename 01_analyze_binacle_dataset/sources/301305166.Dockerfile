# Version: 1.0

# Dockerfile for building boost for android
# https://github.com/dec1/Boost-for-Android
# creates docker container with all tools, libraries and sources required to build boost for android.

# Author: Declan Moran
# www.silverglint.com


# Usage: 
#------
# > git clone https://github.com/dec1/boost-for-android
# > cd boost-for-android
#
# build docker image "my_img_droid" from the dockerfile in "docker" dir
# > docker build -t my_img_droid ./docker
#
# run docker container "my_ctr_droid" from this image, mounting the current dir. (Need to pass absolute host paths to mount volume- hence "pwd")
# > docker run  -v $(pwd):/home/docker-share/boost-for-android -it --entrypoint=/bin/bash --name my_ctr_droid my_img_droid 
#
# Now inside docker container
# $ cd /home/docker-share/boost-for-android
#
# Modify ./doIt.sh (on host), to match the boost and android ndk versions/paths in the "Configure here" section below
# Build from running docker container. 
# $./doIt.sh
#
# Exit container, when build is finsihed,
# $ exit
#
# "./build" dir contains required build, but owned by root. chown to your username/group
# > sudo chown -R <username>:<group> ./build
# 
# Note: If you want to edit the boost source you can download it to this host dir and set doIt.sh to use this instead of the boost version downloaded by the image
# This is necessary for boost version 1.70.0, which seems to contain a bug. Workaround here: https://github.com/boostorg/build/issues/385



FROM amd64/ubuntu:18.04
 
 
## --------------------------------------------------------------------
##              Configure here
# ---------------------------------------------------------------------
# ---------------------------------------------------------------------
# Here you can speciofy exactly what boost, android ndk (and sdk) version you want to use.

# (1) BOOST
ARG BOOST_FILE_BASE=boost_1_69_0
ARG BOOST_VER=1.69.0
ARG BOOST_URL_BASE=https://dl.bintray.com/boostorg/release

# this is where the boost for android repo is mounted/shared to
ARG BOOST_FOR_ANDROID_PATH=/home/docker-share/boost-for-android

# this is where boost src will be extracted to
ARG BOOST_SRC_DIR_BASE=/home/docker-share/boost-src  



# (2) Android SDK
# https://developer.android.com/studio#downloads
ARG SDK_URL_BASE=https://dl.google.com/android/repository
ARG SDK_FILE=sdk-tools-linux-4333796.zip

# the sdk plaform to use 
# https://developer.android.com/guide/topics/manifest/uses-sdk-element
ARG ANDROID_SDK_PLATFORM_VERS="platforms;android-28"



# (3) Android NDK
# https://developer.android.com/ndk/downloads
ARG NDK_URL_BASE=https://dl.google.com/android/repository
ARG NDK_FILE=android-ndk-r19c-linux-x86_64.zip
# ---------------------------------------------------------------------
## --------------------------------------------------------------------

RUN apt-get update
RUN apt-get -y dist-upgrade


# for downloading archives
RUN apt-get -y install wget

# for unzipping downloaded android archives
RUN apt-get -y install zip 

RUN apt-get -y install openjdk-8-jdk
RUN apt-get -y install lib32z1


# need this this to install some (32 bit) prerequisites for android builds 
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y  libc6:i386 libncurses5:i386 libstdc++6:i386 libbz2-1.0:i386


# need c compiler to set up create boost build system (before building boost with it and android toolchain)
RUN apt-get -y install build-essential 
RUN apt-get -y install libc6-dev-i386
RUN apt-get -y install clang


#--------------------------------------

ARG ANDROID_HOME=/home/android
WORKDIR ${ANDROID_HOME}


# SDK
# ----
# download android sdk command line tools
RUN wget ${SDK_URL_BASE}/$SDK_FILE
RUN unzip $SDK_FILE 

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools


RUN yes | sdkmanager --licenses

RUN sdkmanager "platform-tools" $ANDROID_SDK_PLATFORM_VERS
#RUN sdkmanager "platform-tools" "platforms;android-28" 


# NDK
# ----
RUN wget ${NDK_URL_BASE}/$NDK_FILE
RUN unzip $NDK_FILE 


# BOOST
#------

# this is where the boost for android repo is cloned to
# WORKDIR $BOOST_FOR_ANDROID_PATH


ARG BOOST_FILE=${BOOST_FILE_BASE}.tar.gz
ARG BOOST_SRC_DIR=${BOOST_SRC_DIR_BASE}/$BOOST_VER  

RUN wget ${BOOST_URL_BASE}/${BOOST_VER}/source/$BOOST_FILE
RUN mkdir -p $BOOST_SRC_DIR


RUN tar xvzf $BOOST_FILE -C $BOOST_SRC_DIR --strip-components 1
 # tar xvzf /home/android/boost_1_70_0.tar.gz -C /home/docker-share/boost/src/1.70.0 --strip-components 1

RUN echo $BOOST_SRC_DIR
