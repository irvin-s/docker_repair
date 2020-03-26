# This is based on itzg/minecraft-server  
FROM java:8  
MAINTAINER Justin Theberge <theberge.justin@gmail.com>  
  
RUN apt-get update && apt-get install -y wget unzip  
  
EXPOSE 25565  
ADD start.sh /start  
  
VOLUME /data  
ADD server.properties /tmp/server.properties  
WORKDIR /data  
  
CMD /start  
  
ENV MOTD FTB DW20 1.12 1.2.0 Powered by Docker  
ENV LEVEL world  
ENV JVM_OPTS -Xms2048m -Xmx2048m  
ENV MODPACK FTB Presents Direwolf20 1.12  
ENV UPDATE yes  

