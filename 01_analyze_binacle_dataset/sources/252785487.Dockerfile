FROM zookeeper  
MAINTAINER Come Maestracci <come@sensewaves.io>  
  
  
  
ARG DISTRO_NAME=zookeeper-3.4.10  
  
ENV ZOO_USER=zookeeper \  
ZOO_CONF_DIR=/conf \  
ZOO_DATA_DIR=/data \  
ZOO_DATA_LOG_DIR=/datalog \  
ZOO_PORT=2181 \  
ZOO_TICK_TIME=2000 \  
ZOO_INIT_LIMIT=5 \  
ZOO_SYNC_LIMIT=2 \  
ZOO_AUTO_PURGE_INTERVAL=1  
  
  
  
COPY docker-entrypoint.sh /  
RUN chmod +x /docker-entrypoint.sh  
CMD ["zkServer.sh", "start-foreground"]  

