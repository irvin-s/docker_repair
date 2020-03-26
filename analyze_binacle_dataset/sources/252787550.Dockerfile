FROM ubuntu:17.10  
MAINTAINER Jan Broeckhove  
ENV LLVM_VERSION=6.0  
ENV CONTAINER_USER="broeckho"  
  
RUN apt-get update && apt-get -y upgrade  
  
RUN apt-get -y --no-install-recommends install \  
aptitude \  
apt-utils \  
automake \  
autoconf \  
autoconf-archive \  
bash-completion \  
build-essential \  
binutils-dev \  
build-essential \  
cmake \  
coreutils \  
curl \  
doxygen \  
gcc \  
g++ \  
git \  
libtool \  
libboost-all-dev \  
libgl1-mesa-dev \  
libx11-dev libxfixes-dev libxi-dev \  
libxcb1-dev libx11-xcb-dev libxcb-glx0-dev \  
libdbus-1-dev libxkbcommon-dev libxkbcommon-x11-dev \  
zlib1g-dev libssl-dev \  
make \  
python \  
python-dev \  
python-pip \  
python-software-properties \  
software-properties-common \  
tar \  
tree \  
unzip \  
wget \  
xz-utils  
  
RUN apt-get -y clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*  
  
  
# Add non-root user for container but give it sudo access.  
# Password is the same as the username  
RUN useradd -m ${CONTAINER_USER} && \  
echo ${CONTAINER_USER}:${CONTAINER_USER} | chpasswd  
USER ${CONTAINER_USER}  

