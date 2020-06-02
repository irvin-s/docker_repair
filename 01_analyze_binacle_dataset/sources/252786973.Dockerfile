FROM ubuntu:xenial  
  
RUN apt-get update -q && \  
apt-get upgrade -qy && \  
apt-get install -qy software-properties-common && \  
add-apt-repository -u -y ppa:deluge-team/ppa && \  
apt-get install -qy deluged && \  
apt-get install -qy deluge-web && \  
apt-get clean  
  
ADD launch.sh /launch.sh  
  
RUN chmod +x "/launch.sh"  
  
VOLUME ["/data/deluge"]  
VOLUME ["/data/downloads"]  
  
EXPOSE 53160  
EXPOSE 53160/udp  
EXPOSE 8112  
EXPOSE 58846  
  
CMD ["/launch.sh"]  
  

