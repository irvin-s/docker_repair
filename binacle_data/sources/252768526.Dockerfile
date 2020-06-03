FROM debian:jessie  
  
MAINTAINER gijsmolenaar@gmail.com  
  
RUN apt-get update && \  
apt-get install -y \  
python-pip \  
openvpn \  
dialog \  
&& \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD . /menu  
  
RUN cd /menu && pip install .  
  
CMD /usr/local/bin/anansi-menu.py  

