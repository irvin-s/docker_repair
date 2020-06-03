FROM duffqiu/zookeeper:latest  
MAINTAINER duffqiu@gmail.com  
  
WORKDIR /  
  
ADD zookeeper-3.6.0-SNAPSHOT.tar.gz /zk-tmp.tar.gz  
RUN mv /zk-tmp.tar.gz/zookeeper-3.6.0-SNAPSHOT /zookeeper-3.6.0  
RUN rm -rf /zk-tmp.tar.gz  
  
ADD conf/zoo.cfg.tmp /zookeeper-3.6.0/conf/zoo.cfg.tmpl  
  
ADD startzk /usr/bin/startzk  
  
RUN chmod +x /usr/bin/startzk  
  
EXPOSE 21810 28880 38880  
#ENV JVMFLAGS=-Dsun.net.inetaddr.ttl=0  
WORKDIR /zookeeper-3.6.0  
  
ENTRYPOINT [ "/usr/bin/startzk" ]  

