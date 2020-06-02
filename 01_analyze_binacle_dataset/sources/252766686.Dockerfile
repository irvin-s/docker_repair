FROM debian:jessie  
  
LABEL maintainer="akshmakov@gmail.com"  
  
ENV DEBIAN_FRONTEND noninteractive  
  
COPY . /workspace  
  
## Install and Build Clean up in one step  
## Minimize image size despite in-situ build  
RUN apt-get update && \  
apt-get install -y \  
build-essential \  
openocd \  
libreadline-dev \  
libwxgtk3.0-dev \  
usbutils \  
&& \  
make -C /workspace && \  
cp /workspace/bin/* \  
/usr/local/bin/ && \  
rm -rf workspace && \  
apt-get purge -y \  
build-essential \  
libreadline-dev \  
libwxgtk3.0-dev && \  
apt-get autoremove -y && \  
rm -rf \  
/var/lib/apt/lists/*  
  
  

