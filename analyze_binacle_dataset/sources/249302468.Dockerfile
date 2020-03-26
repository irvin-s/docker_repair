FROM ubuntu:17.10
LABEL maintainer="Andreas Seiderer <seiderer@hcm-lab.de>"

# getting required packages, the source code and create a build with default settings
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y mc nano htop build-essential git cmake libcairo-dev libsdl2-dev portaudio19-dev libavcodec-dev libavformat-dev libavdevice-dev libswscale-dev openjdk-8-jdk python3.6-dev && \
    cd ~ && mkdir code && cd code && mkdir SSI && cd SSI && git clone https://github.com/hcmlab/mobileSSI.git && \
    mkdir ssi-build && cd ssi-build && cmake ../mobileSSI/ -DOPENSSI_BUILD_WEBSOCKET=ON && mkdir ../mobileSSI/bin_cmake/ && mkdir ../mobileSSI/bin_cmake/Linux && make -j install
