FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get -y install curl jq && \  
apt-get clean -q  
  
ENV SERVICE_GRAFANA_HOST grafana  
ENV SERVICE_GRAFANA_PORT 3000  
ENV SERVICE_GRAFANA_USERNAME "admin"  
ENV SERVICE_GRAFANA_PASSWORD "admin"  
ADD startup.sh /usr/bin/startup.sh  
  
CMD ["/usr/bin/startup.sh"]  

