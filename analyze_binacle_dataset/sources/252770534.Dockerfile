FROM ubuntu:latest  
  
VOLUME /root/.kodi  
VOLUME /root/.config  
  
RUN apt-get update \  
&& apt-get install -y kodi \  
&& rm -rf /var/lib/apt/lists/*  
  
CMD [ "kodi" ]  

