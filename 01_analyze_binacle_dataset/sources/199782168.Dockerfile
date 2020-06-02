# Set the base image to Ubuntu
FROM ubuntu:16.04

MAINTAINER Jeremy Magland

RUN apt-get update

# Install qt5
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:ubuntu-sdk-team/ppa
RUN apt-get update
RUN apt-get install -y qtdeclarative5-dev
RUN apt-get install -y qt5-default qtbase5-dev qtscript5-dev make g++

# Install nodejs and npm
RUN apt-get install -y nodejs npm

# Install fftw and octave
RUN apt-get install -y libfftw3-dev octave

RUN apt-get install -y git

ADD . /home/mluser/dev/mountainlab
WORKDIR /home/mluser/dev/mountainlab
RUN ./compile_components.sh prv mdaconvert mountainprocess

ENV PATH /home/mluser/dev/mountainlab/bin:$PATH

##########################################
RUN ln -s /home/mluser/dev/mountainlab/prv /base
