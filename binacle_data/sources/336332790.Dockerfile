FROM ubuntu:16.04
MAINTAINER Grigori Fursin <Grigori.Fursin@cTuning.org>

# Install standard packages.
RUN apt-get update && apt-get install -y \
    python \
    python-pip \
    python3 \
    python3-pip \
    git zip bzip2 sudo wget \
    libglib2.0-0 libsm6

RUN pip3 install ck
RUN ck  version

# Install CK RPi repo
RUN ck pull repo --url=https://github.com/dividiti/ck-request-asplos18-mobilenets-armcl-opencl
RUN ck pull repo:ck-request-asplos18-results-mobilenets-armcl-opencl

#
CMD bash
