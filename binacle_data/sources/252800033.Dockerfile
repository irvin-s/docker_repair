FROM dimkk/ant  
  
MAINTAINER dimkk  
  
COPY . /var/l2  
  
RUN ant -buildfile "/var/l2/build - Commons.xml" build  
RUN ant -buildfile "/var/l2/build - GameServer.xml" build  
  
WORKDIR /var/l2/dist/gameserver  
  
VOLUME ["/var/l2/dist/gameserver/log"]  
  
CMD ["sh", "GameServer_loop.sh", ">", "gamelog.log", "2>&1"]

