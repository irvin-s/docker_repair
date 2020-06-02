FROM ubuntu:16.04  
  
RUN apt-get update \  
&& apt-get -y \  
install \  
iputils-ping \  
wget \  
dnsutils \  
telnet \  
tcpdump \  
net-tools \  
iproute2 \  
netcat \  
nmap \  
fping \  
curl \  
httpie \  
mysql-client \  
zsh \  
&& apt-get clean \  
&& apt-get autoclean  

