FROM phusion/baseimage  
MAINTAINER David Donchez <david.donchez@gmail.com>  
  
# Installing some net tools  
RUN apt-get update && apt-get -y install traceroute \  
dnsutils \  
mtr-tiny \  
iputils-ping \  
netcat-openbsd \  
wget \  
curl \  
bash \  
htop \  
tcpdump \  
nmap \  
iperf \  
openssh-client \  
jq \  
&& rm -rf /var/lib/apt/lists/*  
  
CMD ["/bin/bash"]  

