FROM ubuntu:xenial  
MAINTAINER atomney <atomney+docker@gmail.com>  
  
RUN apt-get update -q && \  
apt-get install -qy software-properties-common && \  
add-apt-repository ppa:deluge-team/ppa && \  
apt-get update -q && \  
apt-get install -qy deluged deluge-web nano htop && \  
apt-get autoclean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /data && mkdir -p /downloads  
  
COPY core.conf /data/core.conf  
COPY web.conf /data/web.conf  
  
ADD start.sh /start.sh  
  
VOLUME ["/data", "/downloads"]  
  
# Torrent port  
EXPOSE 53160 53160/udp  
  
# WebUI  
EXPOSE 8112  
# Daemon  
EXPOSE 58846  
CMD ["/start.sh"]  
  

