FROM ubuntu  
MAINTAINER DIMKK  
  
COPY . /var/l2/dist/gameserver/data  
  
VOLUME /var/l2/dist/gameserver/data  
  
ENTRYPOINT ls /var/l2/dist/gameserver/data

