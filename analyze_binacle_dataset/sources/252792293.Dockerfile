FROM ubuntu:latest  
MAINTAINER Tomasz Cielecki <tomasz@ostebaronen.dk>  
  
ENV LANG en_US.UTF-8  
ENV DEBIAN_FRONTEND noninteractive  
RUN locale-gen $LANG  
RUN apt-get update && apt-get install -qy \  
software-properties-common  
RUN add-apt-repository ppa:deluge-team/ppa -y \  
&& apt-get update -q \  
&& apt-get upgrade -qy \  
&& apt-get install -qy \  
deluged \  
deluge-web \  
deluge-console \  
&& apt-get autoremove -y \  
&& apt-get autoclean -y \  
&& apt-get clean  
  
# Managment  
EXPOSE 58846  
# Torrent ports  
EXPOSE 6881-6891  
# Deluge-web  
EXPOSE 8112  
  
# Entrypoint  
COPY ./entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  

