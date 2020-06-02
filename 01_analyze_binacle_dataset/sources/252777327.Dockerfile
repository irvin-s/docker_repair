FROM ubuntu:18.04  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
autoconf \  
automake \  
bison \  
dejagnu \  
flex \  
gawk \  
gdb \  
git \  
install-info \  
iproute2 \  
iputils-ping \  
libc-ares-dev \  
libjson-c-dev \  
libpam0g-dev \  
libtool \  
libreadline-dev \  
libsystemd-dev \  
make \  
mininet \  
net-tools \  
pkg-config \  
python-pip \  
python-sphinx \  
python3-dev \  
texinfo  
  
RUN pip install \  
ipaddr \  
pytest \  
exabgp==3.4.17  
  
RUN useradd -d /var/run/exabgp/ -s /bin/false exabgp \  
&& groupadd -g 92 frr \  
&& groupadd -r -g 85 frrvty \  
&& adduser --system --ingroup frr --home /var/run/frr/ \  
\--gecos "FRR suite" \--shell /sbin/nologin frr \  
&& usermod -a -G frrvty frr  
  
COPY . /opt/topotests  
  
ENTRYPOINT [ "/opt/topotests/docker/start.sh" ]  

