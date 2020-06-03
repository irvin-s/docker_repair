# Copyright 2015 Sean Nelson <audiohacked@gmail.com>  
FROM openjdk:8-jre-alpine  
MAINTAINER Sean Nelson <audiohacked@gmail.com>  
  
ENV BASE_URL="http://ftb.cursecdn.com/FTB2/modpacks/FTBPyramidReborn" \  
FTB_VERSION="2_1_1" \  
SERVER_FILE="FTBPyramidRebornServer.zip" \  
SERVER_PORT=25565  
WORKDIR /minecraft  
  
USER root  
COPY CheckEula.sh /minecraft/  
RUN adduser -D minecraft && \  
apk --no-cache add wget && \  
chown -R minecraft:minecraft /minecraft  
  
USER minecraft  
RUN mkdir -p /minecraft/world && \  
wget ${BASE_URL}/${FTB_VERSION}/${SERVER_FILE} && \  
unzip ${SERVER_FILE} && \  
chmod u+x FTBInstall.sh ServerStart.sh CheckEula.sh && \  
sed -i '2i /bin/sh /minecraft/CheckEula.sh' /minecraft/ServerStart.sh && \  
/minecraft/FTBInstall.sh  
  
EXPOSE ${SERVER_PORT}  
VOLUME ["/minecraft/world", "/minecraft/backups"]  
CMD ["/bin/sh", "/minecraft/ServerStart.sh"]  

