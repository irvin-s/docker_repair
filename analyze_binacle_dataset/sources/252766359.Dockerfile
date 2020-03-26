FROM abobier/ubuntu-dri_mesa  
MAINTAINER abobier <abobier@gmail.com>  
  
RUN apt-get update && apt-get install -y software-properties-common  
RUN add-apt-repository ppa:team-xbmc/ppa  
RUN apt-get update && apt-get install -y kodi  
  
ENTRYPOINT [ "/usr/bin/kodi" ]  
  

