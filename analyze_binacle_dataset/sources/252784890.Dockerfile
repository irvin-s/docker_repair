FROM ubuntu:16.04  
  
RUN apt-get update && apt-get -y upgrade  
RUN apt-get -y --no-install-recommends install \  
automake \  
aptitude \  
bash-completion \  
build-essential \  
cmake \  
cmake-curses-gui \  
coreutils \  
gcc \  
g++ \  
gdb \  
git-core \  
htop \  
libtool \  
mercurial \  
ncdu \  
ninja-build \  
python \  
python-dev \  
python-pip \  
python-software-properties \  
software-properties-common \  
subversion \  
tree \  
unzip \  
wget \  
vim  
  
WORKDIR /usr/src/  
RUN wget https://www.openfabrics.org/downloads/qperf/qperf-0.4.9.tar.gz \  
&& tar -xzvf qperf-0.4.9.tar.gz \  
&& rm qperf-0.4.9.tar.gz  
WORKDIR /usr/src/qperf-0.4.9  
RUN ./configure && make

