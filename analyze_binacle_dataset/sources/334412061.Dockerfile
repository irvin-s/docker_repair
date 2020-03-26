# Start with a base docker image that contains CUDA and CUDNN
FROM cuda:base

MAINTAINER Alues <alues@icloud.com>

# Remove Nvidia GPG Key & apt_list
RUN apt-key del 7FA2AF80 \
 && rm -f /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/nvidia-ml.list

# RUN Installation
RUN apt-get update \
 && apt-get install -y sudo net-tools vim

# COPY Software
ARG SoftWare_Root=Deep_Learning
WORKDIR /root/${SoftWare_Root}

# Copy Mxnet
ARG Software_Script=Mxnet
COPY ${Software_Script} ./${Software_Script}/

# Copy Python Plugins
ARG Software_Script=Python_PKG
COPY ${Software_Script} ./${Software_Script}/

# Copy SSH
ARG Software_Script=SSH
COPY ${Software_Script} ./${Software_Script}/

# Copy BASH Script
COPY ./Install_*.sh ./

# Install Env & Mxnet
RUN bash Install_Env.sh \
 && bash Install_Mxnet.sh

# Clear Env
WORKDIR /root
RUN rm -rf ${SoftWare_Root}
