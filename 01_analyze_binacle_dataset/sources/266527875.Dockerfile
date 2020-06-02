## Docker build of NVIDIA TensorRT 3.0 RC (Release Candidate)
FROM arm64v8/ubuntu:xenial-20171201

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com

# base URL for NVIDIA libs
ARG URL=http://developer.download.nvidia.com/devzone/devcenter/mobile/jetpack_l4t/3.2/pwv346/JetPackL4T_32_b157

# this is the base container for the Jetson TX2 board with drivers (but without cuda)
RUN apt-get update && apt-get install -y bzip2 curl unp sudo

# Change permissions away from user 1000 or install will squawk
RUN chown root /etc/passwd /etc/sudoers /usr/lib/sudo/sudoers.so /etc/sudoers.d/README

WORKDIR /tmp

# drivers first
# Resultant file: Tegra186_Linux_R28.1.0_aarch64.tbz2
RUN curl -sL http://developer.nvidia.com/embedded/dlc/l4t-jetson-tx2-driver-package-28-2 | tar xfj -
RUN Linux_for_Tegra/apply_binaries.sh -r /

## Pull the rest of the jetpack and install
# CUDA 9.0 (N.B. the fs lib copies above contain an essential libcuda.so that isn't present in the below packages
RUN curl $URL/cuda-repo-l4t-9-0-local_9.0.252-1_arm64.deb -so cuda-repo-l4t_arm64.deb && dpkg -i /tmp/cuda-repo-l4t_arm64.deb
RUN apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
RUN apt-get update && apt-get install -y cuda-toolkit-9.0
# CUDNN libs
RUN curl $URL/libcudnn7_7.0.5.13-1+cuda9.0_arm64.deb -so /tmp/libcudnn_arm64.deb && dpkg -i /tmp/libcudnn_arm64.deb
RUN curl $URL/libcudnn7-dev_7.0.5.13-1+cuda9.0_arm64.deb -so /tmp/libcudnn-dev_arm64.deb && dpkg -i /tmp/libcudnn-dev_arm64.deb

# GIE = TensorRT
RUN curl $URL/nv-tensorrt-repo-ubuntu1604-pipecleaner-cuda9.0-trt3.0-20171116_1-1_arm64.deb -so /tmp/nv-tensorrt-repo-ubuntu1604-pipecleaner-cuda9.0-trt3.0-20171116_1-1_arm64.deb
RUN dpkg -i /tmp/nv-tensorrt-repo-ubuntu1604-pipecleaner-cuda9.0-trt3.0-20171116_1-1_arm64.deb

# Ensure libnvinfer and others are installed
RUN dpkg -i /var/nv-tensorrt-repo-pipecleaner-cuda9.0-trt3.0-20171116/libnvinfer4_4.0.0-1+cuda9.0_arm64.deb
RUN dpkg -i /var/nv-tensorrt-repo-pipecleaner-cuda9.0-trt3.0-20171116/libnvinfer-dev_4.0.0-1+cuda9.0_arm64.deb
RUN echo "/usr/lib/aarch64-linux-gnu/tegra" >> /etc/ld.so.conf.d/nvidia-tegra.conf

# TODO: figure out the source of these libs, they're on the fs prepped by jetpack but not in downloadable sample root fs
#RUN rm /usr/lib/aarch64-linux-gnu/libcuda.so* /usr/lib/aarch64-linux-gnu/tegra/libcuda.so*
#RUN ln -s /usr/lib/aarch64-linux-gnu/tegra/libcuda.so.1.1 /usr/lib/aarch64-linux-gnu/tegra/libcuda.so
#RUN curl -sL http://1dd40.http.tor01.cdn.softlayer.net/nvidia-media/JetPack-L4T-3.2-linux-x64_b157-rootfs-extracts.tar.gz | tar xfz - -C /

# Dev
RUN apt-get install -y vim

## Clean up
RUN rm -fr /tmp/* /var/cache/apt/* && apt-get clean
