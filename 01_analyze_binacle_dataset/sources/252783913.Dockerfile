FROM ubuntu:14.04  
MAINTAINER binss(i@binss.me)  
  
RUN apt-get update && \  
apt-get -y install python-pip && \  
pip install shadowsocks && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
CMD ["ssserver", "-c", "/etc/shadowsocks/shadowsocks.json"]  

