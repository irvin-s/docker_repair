## Docker build of NVIDIA TensorRT 3.0 RC (Release Candidate)
FROM aarch64/ubuntu

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com

# this is the base container for the Jetson TX2 board with drivers (but without cuda)
RUN apt-get update && apt-get install -y bzip2 curl unp sudo

WORKDIR /

# drivers first
# Resultant file: Tegra186_Linux_R28.1.0_aarch64.tbz2
RUN curl -sL http://developer.nvidia.com/embedded/dlc/l4t-jetson-tx2-driver-package-28-1 | tar xvfj -
# Change permissions away from user 1000 or install will squawk
RUN chown root /etc/passwd /etc/sudoers /usr/lib/sudo/sudoers.so /etc/sudoers.d/README
RUN /Linux_for_Tegra/apply_binaries.sh -r /


## Pull the rest of the jetpack and install
WORKDIR /tmp
RUN curl http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/013/linux-x64/cuda-repo-l4t-8-0-local_8.0.84-1_arm64.deb -so cuda-repo-l4t_arm64.deb && dpkg -i /tmp/cuda-repo-l4t_arm64.deb

RUN apt-get update && apt-get install -y cuda-toolkit-8.0 && rm -fr /tmp/* && apt-get clean && rm -rf /var/cache/apt

RUN curl http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/013/linux-x64/libcudnn6_6.0.21-1+cuda8.0_arm64.deb -so /tmp/libcudnn_arm64.deb && dpkg -i /tmp/libcudnn_arm64.deb && rm -fr /tmp/*

RUN curl http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/013/linux-x64/libcudnn6-dev_6.0.21-1+cuda8.0_arm64.deb -so /tmp/libcudnn-dev_arm64.deb && dpkg -i /tmp/libcudnn-dev_arm64.deb && rm -fr /tmp/*

# GIE = TensorRT
COPY files/nv-tensorrt-repo-ubuntu1604-rc-cuda8.0-trt3.0-20170922_3.0.0-1_arm64.deb /tmp/
RUN dpkg -i /tmp/nv-tensorrt-repo-ubuntu1604-rc-cuda8.0-trt3.0-20170922_3.0.0-1_arm64.deb

# D.R. -- got to do this for some strange reason (for jetson tx2)
RUN ln -s /usr/lib/aarch64-linux-gnu/libcuda.so /usr/lib/aarch64-linux-gnu/libcuda.so.1
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/aarch64-linux-gnu/tegra

# Dev
RUN apt-get install -y vim

# Clean up
RUN rm -fr /tmp/*
RUN apt-get clean

