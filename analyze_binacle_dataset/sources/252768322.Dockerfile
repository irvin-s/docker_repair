FROM buildpack-deps:jessie-curl  
  
ENV RANCHER_COMPOSE_VERSION 0.9.0  
ENV RANCHER_COMPOSE_HOME /usr/lib/rancher-compose  
  
ADD install-tools.sh /usr/local/bin/  
ADD rancher-scripts/*.sh ${RANCHER_COMPOSE_HOME}/  
  
RUN /usr/local/bin/install-tools.sh  
VOLUME ${RANCHER_COMPOSE_HOME}  

