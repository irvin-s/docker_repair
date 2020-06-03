FROM ubuntu:14.04  
MAINTAINER Cornel  
  
# install Java 7 & curl  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 && \  
a2enmod proxy && \  
a2enmod proxy_balancer && \  
a2enmod proxy_http && \  
a2enmod proxy_ajp && \  
a2enmod proxy_connect && \  
a2enmod lbmethod_bybusyness && \  
a2enmod lbmethod_byrequests  
  
# copy some scripts to run Apache Load Balancer  
COPY scripts/start-lb.sh /start-lb.sh  
COPY scripts/lb-add-worker.sh /lb-add-worker.sh  
COPY scripts/lb-rm-worker.sh /lb-rm-worker.sh  
  
# copy the config files for the load balancer  
COPY lb-conf/ports.conf /etc/apache2/  
COPY lb-conf/proxy.conf /etc/apache2/mods-available/  
COPY lb-conf/proxy_balancer.conf /etc/apache2/mods-available/  
  
### Apache ports  
# 8080: default website  
EXPOSE 8080  
# by default, this container is a Spark Worker  
CMD ["/start-lb.sh"]  

