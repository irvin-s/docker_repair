FROM ryanckoch/docker-ubuntu-14.04  
ENV DEBIAN_FRONTEND noninteractive  
  
VOLUME ["/opt/mangos/etc", "/opt/mangos/data", "/opt/mangos/logs"]  
  
ADD mangoszero-initdb.sh /mangoszero-initdb.sh  
  
RUN apt-get update && \  
apt-get install -y mysql-client git && \  
rm -rf /var/lib/apt/lists/* && \  
chmod +x /mangoszero-initdb.sh  
  
ENTRYPOINT ["/mangoszero-initdb.sh"]  

