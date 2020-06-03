# Copyright 2015 Sean Nelson <audiohacked@gmail.com>  
FROM audiohacked/steamcmd:jessie  
MAINTAINER Sean Nelson <audiohacked@gmail.com>  
  
ARG BASE_URL="http://terraria.org/server/terraria-server-linux-1308.tar.gz"  
ARG TERRARIA_SERVER_PATH  
ENV TERRARIA_SERVER_PATH ${TERRARIA_SERVER_PATH:-"terraria-server-linux-1308"}  
ENV SERVER_NAME "Terraria Linux Server"  
ENV SERVER_PORT 7777  
ENV SERVER_PLAYERS 6  
ENV WORLD_NAME "Terraria"  
ENV WORLD_SIZE 3  
ENV WORLD_DIFFICULTY 0  
ENV MOTD "Terraria 1.3.0.8"  
ENV PATH /terraria:$PATH  
ENV SERVER_PASSWORD ""  
WORKDIR /terraria  
  
USER root  
COPY update.sh /terraria/  
COPY start.sh /terraria/  
COPY settings.sh /terraria/  
RUN apt-get update && apt-get install -y --no-install-recommends \  
mono-runtime \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& curl -SL $BASE_URL | tar -xzC /terraria \  
&& chmod u+x update.sh start.sh settings.sh \  
&& mkdir -p /terraria/Worlds \  
&& chown -R steam:steam /terraria  
  
VOLUME ["/terraria/Worlds", "/terraria"]  
  
USER steam  
CMD ["/bin/bash", "start.sh"]  
  
EXPOSE ${SERVER_PORT}  

