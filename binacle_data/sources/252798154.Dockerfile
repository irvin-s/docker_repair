FROM debian:stretch  
  
RUN apt-get update && apt-get install -y \  
binfmt-support \  
cmake \  
debhelper \  
devscripts \  
git \  
gksu \  
intltool \  
libarchive-dev \  
libcurl4-openssl-dev \  
libgtkmm-3.0-dev \  
libldap2-dev \  
qemu-user-static \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /app/src  
RUN git clone \--depth 1 https://github.com/raspberrypi/piserver.git  
  
WORKDIR /app/src/piserver  
RUN debuild -uc -us  

