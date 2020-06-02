FROM ubuntu:trusty  
  
RUN apt-get update -q && \  
apt-get install -qy software-properties-common && \  
add-apt-repository ppa:deluge-team/ppa && \  
apt-get update -q && \  
apt-get install -qy deluged deluge-web  
  
ADD start.sh /start.sh  
  
VOLUME ["/data"]  
# Torrent port  
EXPOSE 53160  
EXPOSE 53160/udp  
# WebUI  
EXPOSE 8112  
# Daemon  
EXPOSE 58846  
CMD ["/start.sh"]  

