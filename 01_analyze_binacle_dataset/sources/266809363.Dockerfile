FROM openhorizon/cuda-tx1-fullcudnn

#AUTHOR dima@us.ibm.com
MAINTAINER dyec@us.ibm.com

WORKDIR /tmp
RUN mkdir /tmp/OpenCV4Tegra
WORKDIR /tmp/OpenCV4Tegra
RUN curl http://AFED.http.sjc01.cdn.softlayer.net/jetson2.3/libopencv4tegra-repo_2.4.13-17-g5317135_arm64_l4t-r24.deb -o /tmp/OpenCV4Tegra/libopencv4tegra-repo_2.4.13-17-g5317135_arm64_l4t-r24.deb
COPY ocv.sh /tmp/OpenCV4Tegra
RUN ./ocv.sh libopencv4tegra-repo_2.4.13-17-g5317135_arm64_l4t-r24.deb 
WORKDIR /
RUN rm -r /tmp/OpenCV4Tegra


# RUN apt-get update
