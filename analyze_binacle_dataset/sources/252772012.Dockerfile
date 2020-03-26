# Copyright 2015 Sean Nelson <audiohacked@gmail.com>  
FROM audiohacked/steamcmd:jessie  
MAINTAINER Sean Nelson <audiohacked@gmail.com>  
  
ENV SERVER_TOKEN ${SERVER_TOKEN:-""}  
ENV SERVER_NAME "Dont Starve Together Server"  
ENV SERVER_DESCRIPTION "A very nice server description"  
ENV SERVER_INTENTION cooperative  
ENV SERVER_PORT 10999  
ENV SERVER_GAME_MODE endless  
ENV SERVER_PLAYERS 6  
ENV PATH /dontstarve:$PATH  
  
WORKDIR /dontstarve  
  
USER root  
  
COPY update.sh /dontstarve/  
COPY start.sh /dontstarve/  
COPY settings.sh /dontstarve/  
COPY servertoken.sh /dontstarve/  
  
RUN dpkg --add-architecture i386 && \  
apt-get update && apt-get install -y --no-install-recommends \  
lib32gcc1 \  
lib32stdc++6 \  
libcurl4-gnutls-dev:i386 \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& chmod u+x update.sh start.sh settings.sh servertoken.sh \  
&& mkdir -p /dontstarve/config \  
&& mkdir -p /dontstarve/data \  
&& chown -R steam:steam /dontstarve  
  
VOLUME ["/dontstarve/config", "/dontstarve/data"]  
  
USER steam  
EXPOSE ${SERVER_PORT}  
RUN ["/bin/bash", "./update.sh"]  
CMD ["/bin/bash", "./start.sh"]  
  

