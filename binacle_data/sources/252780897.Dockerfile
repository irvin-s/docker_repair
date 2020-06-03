FROM ubuntu:16.04  
MAINTAINER Jérémy SEBAN <jeremy@seban.eu>  
  
COPY ./start.sh /bin/start_factorio  
RUN apt-get update && \  
apt-get install -y wget && \  
rm -rf /var/lib/apt/lists/* && \  
chmod +x /bin/start_factorio  
  
VOLUME /data  
EXPOSE 34197/udp  
  
ENTRYPOINT ["/bin/start_factorio"]  

