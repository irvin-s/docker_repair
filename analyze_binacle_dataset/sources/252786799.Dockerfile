#  
# LinuxGSM Dockerfile  
#  
# https://github.com/GameServerManagers/LinuxGSM-Docker  
#  
  
FROM ubuntu:16.04  
LABEL maintainer="BourneID <admin@h-r-l.co.uk>, on behalf of LinuxGSM"  
  
ENV DEBIAN_FRONTEND noninteractive  
  
## Base System  
RUN dpkg --add-architecture i386 && \  
apt-get update && \  
apt-get install -y \  
bc \  
binutils \  
bsdmainutils \  
bzip2 \  
ca-certificates \  
curl \  
default-jdk \  
file \  
gzip \  
lib32gcc1 \  
lib32tinfo5 \  
libcurl4-gnutls-dev:i386 \  
libdbus-glib-1-2:i386 \  
libglu1-mesa:i386 \  
libgtk2.0-0:i386 \  
libldap-2.4-2:i386 \  
libmariadb2 \  
libncurses5:i386 \  
libnm-glib-dev:i386 \  
libopenal1:i386 \  
libsdl1.2debian \  
libssl1.0.0:i386 \  
libstdc++5:i386 \  
libstdc++6 \  
libstdc++6:i386 \  
libtbb2 \  
libtcmalloc-minimal4:i386 \  
libusb-1.0-0-dev:i386 \  
libxrandr2:i386 \  
libxtst6:i386 \  
libxxf86vm1:i386 \  
mailutils \  
postfix \  
python \  
speex:i386 \  
tmux \  
unzip \  
util-linux \  
wget \  
xz-utils \  
zlib1g:i386 \  
&& rm -rf /var/lib/apt/lists/*

