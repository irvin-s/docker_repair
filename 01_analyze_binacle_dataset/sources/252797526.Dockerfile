# Simple container including nintendo-swtich / nvidia tegra linux toolchain  
FROM ubuntu:18.04  
# Software requirements  
RUN apt-get update && \  
apt-get -yq --no-install-recommends install \  
unzip \  
build-essential \  
libssl-dev \  
swig \  
bison \  
flex \  
python3 \  
python-dev \  
python3-usb \  
libusb-1.0-0-dev \  
zlib1g-dev \  
bc \  
linux-firmware \  
cmake \  
libpci-dev \  
git \  
pkg-config \  
ca-certificates \  
wget \  
moreutils \  
gcc-7-aarch64-linux-gnu \  
gcc-aarch64-linux-gnu \  
gcc-7-arm-linux-gnueabi \  
gcc-arm-linux-gnueabi \  
debootstrap \  
binfmt-support \  
dosfstools \  
qemu-user-static && \  
apt-get clean  
  
COPY brcmfmac4356-pcie.txt /lib/firmware/brcm/brcmfmac4356-pcie.txt  
  
VOLUME /source  
WORKDIR /source  
CMD bash  

