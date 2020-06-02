#Prometheus Config Store Dockerfile  
FROM alpine  
  
MAINTAINER Virgil Chereches (virgil.chereches@gmx.net)  
  
RUN mkdir -p /etc/prometheus  
  
ADD prometheus.yml /etc/prometheus/prometheus.yml  
  
VOLUME /etc/prometheus  
  
CMD ["/bin/sh"]  

