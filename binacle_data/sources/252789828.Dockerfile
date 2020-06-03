  
# docker-simba  
FROM debian:stretch  
  
LABEL maintainer="caligari@treboada.net"  
  
ENV HOME_DIR=/usr/local/simba  
  
# system packages  
RUN apt-get update \  
&& basicDeps=' \  
sudo \  
unrar-free \  
unzip \  
wget \  
' \  
develDeps=' \  
autoconf \  
automake \  
bison \  
ckermit \  
cloc \  
cppcheck \  
flex \  
g++ \  
gawk \  
gcc \  
git \  
gperf \  
doxygen \  
help2man \  
lcov \  
libexpat-dev \  
libtool-bin \  
make \  
ncurses-dev \  
pmccabe \  
python \  
python-pip \  
python-pyelftools \  
python3-minimal \  
texinfo \  
valgrind \  
' \  
avrDeps=' \  
avr-libc \  
avrdude \  
binutils-avr \  
gcc-avr \  
gdb-avr \  
' \  
armDeps=' \  
bossa-cli \  
gcc-arm-none-eabi \  
' \  
&& DEBIAN_FRONTEND=noninteractive \  
apt-get install -qy $basicDeps $develDeps $avrDeps $armDeps \  
&& rm -rf /var/lib/apt/lists/*  
  
# python modules  
RUN pip install \  
pyserial xpect readchar sphinx breathe sphinx_rtd_theme  
  
# regular user  
RUN useradd --create-home --home-dir $HOME_DIR \--shell /bin/bash simba \  
&& echo 'simba ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/simba  
USER simba  
WORKDIR $HOME_DIR  
  
# ESP32 SDK  
ADD dist/esp32/xtensa-esp32-elf-linux64-1.22.0-59.tar.gz $HOME_DIR  
  
# ESP8266 SDK  
RUN git clone \--recursive https://github.com/pfalcon/esp-open-sdk \  
&& cd esp-open-sdk && make && cd $HOME_DIR  
  
# ToDo: download S32 SDK from NXP  
# Simba sources  
RUN git clone \--recursive https://github.com/eerimoq/simba  
  

