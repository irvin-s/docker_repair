# Download and install Matlab Runtime v9.1 (2016b)
#
# This docker file will configure an environment into which the Matlab compiler
# runtime will be installed and in which stand-alone matlab routines (such as
# those created with Matlab's deploytool) can be executed.
#
# See http://www.mathworks.com/products/compiler/mcr/ for more info.

FROM nvidia/cuda:8.0-cudnn5-devel-centos7
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum update -y && yum install -y epel-release && \
    yum -y group install "Development Tools" && yum install -y \
    unzip \
    xorg \
    wget \
    curl \
    vim

ENV MCR_ROOT /opt/mcr
RUN mkdir /mcr-install $MCR_ROOT

WORKDIR /mcr-install
RUN wget http://www.mathworks.com/supportfiles/downloads/R2016b/deployment_files/R2016b/installers/glnxa64/MCR_R2016b_glnxa64_installer.zip && \
    unzip -q MCR_R2016b_glnxa64_installer.zip && \
    ./install -destinationFolder $MCR_ROOT -agreeToLicense yes -mode silent

RUN rm -fr /mcr-install

# Configure environment variables for Matlab Runtime R2016b
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/opt/mcr/v91/runtime/glnxa64:/opt/mcr/v91/bin/glnxa64:/opt/mcr/v91/sys/os/glnxa64

# Include hello_world compiled using Matlab R2016b Compiler
WORKDIR /
# https://support.opensciencegrid.org/support/solutions/articles/5000660751-basics-of-compiled-matlab-applications-hello-world-example
COPY hello_world .
# Run the Matlab command 'gpuDevice'
COPY gpu_devices .
