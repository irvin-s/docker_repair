FROM wernight/plex-media-server  
  
USER root  
RUN usermod -a -G users plex  
USER plex  

