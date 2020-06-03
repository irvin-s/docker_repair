FROM debian:sid  
LABEL maintainer="antoinegrondin@gmail.com"  
LABEL description="A quick linux environment to launch from macOS."  
  
RUN /bin/bash -c 'apt-get update && apt-get install -y --force-yes \  
sudo \  
tmux \  
git \  
vim-nox \  
dstat \  
htop \  
clang \  
gcc \  
fish \  
curl \  
jq \  
build-essential \  
cmake \  
python-dev \  
golang;'  
  
RUN /bin/bash -c ' \  
fish_path=$(which fish); \  
echo $fish_path >> /etc/shells; \  
chsh root -s $fish_path;'  
  
RUN /bin/bash -c 'apt-get install -y --force-yes \  
dmsetup \  
automake \  
autoconf \  
libdevmapper-dev \  
libvirt-dev \  
dh-make \  
cpio;'  

