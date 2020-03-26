FROM phusion/baseimage  
MAINTAINER e0d1n  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN dpkg --add-architecture i386  
RUN apt-get update && apt-get -y upgrade  
  
#-------------------------------------#  
# Install packages from Ubuntu repos #  
#-------------------------------------#  
RUN apt-get install -y \  
sudo \  
build-essential \  
gcc-multilib \  
g++-multilib \  
gdb \  
gdb-multiarch \  
python-dev \  
python3-dev \  
python-pip \  
python3-pip \  
default-jdk \  
net-tools \  
nasm \  
vim \  
tmux \  
zsh \  
ctags \  
git \  
binwalk \  
strace \  
ltrace \  
autoconf \  
socat \  
netcat \  
nmap \  
wget \  
exiftool \  
unzip \  
virtualenvwrapper \  
man-db \  
manpages-dev \  
libini-config-dev \  
libssl-dev \  
libffi-dev \  
libglib2.0-dev \  
libc6:i386 \  
libncurses5:i386 \  
libstdc++6:i386 \  
libc6-dev-i386 \  
gcc-arm-none-eabi \  
libnewlib-arm-none-eabi \  
libstdc++-arm-none-eabi-newlib \  
libnewlib-dev \  
qemu \  
qemu-user \  
qemu-user-static  
  
RUN apt-get -y autoremove  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
#-------------------------------------#  
# Install stuff from pip repos #  
#-------------------------------------#  
RUN pip install \  
pycipher \  
uncompyle \  
ropgadget \  
distorm3 \  
filebytes \  
python-constraint  
  
# install pwntools 3  
RUN pip install --upgrade pwntools  
  
#-------------------------------------#  
# Install stuff from GitHub repos #  
#-------------------------------------#  
# install capstone  
# RUN git clone https://github.com/aquynh/capstone.git /opt/capstone && \  
# cd /opt/capstone && \  
# ./make.sh && \  
# ./make.sh install && \  
# cd bindings/python && \  
# make install && \  
# make install3  
# install radare2  
RUN git clone https://github.com/radare/radare2.git /opt/radare2 && \  
cd /opt/radare2 && \  
git fetch --tags && \  
git checkout $(git describe --tags $(git rev-list --tags --max-count=1)) && \  
./sys/install.sh && \  
make symstall  
  
# install ropper  
RUN git clone https://github.com/sashs/Ropper.git /opt/ropper && \  
cd /opt/ropper && \  
python setup.py install  
RUN rm -rf /opt/ropper  
  
# install ropeme  
RUN git clone https://github.com/packz/ropeme.git /opt/ropeme && \  
sed -i 's/distorm/distorm3/g' /opt/ropeme/ropeme/gadgets.py  
  
# install libc-database  
RUN git clone https://github.com/niklasb/libc-database /opt/libc-database  
  
# install peda  
RUN git clone https://github.com/longld/peda.git /opt/peda  
  
# install gef  
RUN git clone https://github.com/hugsy/gef.git /opt/gef  
  
# install fixenv  
RUN git clone https://github.com/hellman/fixenv /opt/fixenv && \  
cd /opt/fixenv && \  
chmod +x r.sh && \  
ln -s /opt/fixenv/r.sh /usr/local/bin/fixenv  
  
#-------------------------------------#  
# Configuring enviroment #  
#-------------------------------------#  
RUN touch $HOME/.z  
RUN git clone http://github.com/e0d1n/dotfiles.git $HOME/.e0d1n-dotfiles && \  
cd $HOME/.e0d1n-dotfiles && \  
./install.sh  
RUN vim +PlugInstall +qall  
RUN echo 'source /opt/peda/peda.py' > ~/.gdbinit  
RUN chsh -s /bin/zsh  
  
ENTRYPOINT ["/bin/zsh"]  

