# Copyright 2015 Sean Nelson <audiohacked@gmail.com>  
FROM openjdk:alpine  
MAINTAINER Sean Nelson <audiohacked@gmail.com>  
  
ENV BASE_URL="http://ftb.cursecdn.com/FTB2/modpacks/FTBPresentsHermitPack"  
ENV FTB_VERSION="1_7_0"  
ENV SERVER_FILE="FTBPresentsHermitPackServer.zip"  
ENV SERVER_PORT 25565  
WORKDIR /minecraft  
  
USER root  
COPY CheckEula.sh /minecraft/  
RUN adduser -D minecraft && \  
mkdir -p /minecraft/world && \  
apk --no-cache add curl wget && \  
curl -SLO ${BASE_URL}/${FTB_VERSION}/${SERVER_FILE} && \  
unzip ${SERVER_FILE} && \  
chmod u+x FTBInstall.sh ServerStart.sh CheckEula.sh && \  
sed -i '2i /bin/sh /minecraft/CheckEula.sh' /minecraft/ServerStart.sh && \  
chown -R minecraft:minecraft /minecraft  
  
USER minecraft  
RUN /minecraft/FTBInstall.sh  
EXPOSE ${SERVER_PORT}  
VOLUME ["/minecraft/world"]  
  
CMD ["/bin/sh", "/minecraft/ServerStart.sh"]  

