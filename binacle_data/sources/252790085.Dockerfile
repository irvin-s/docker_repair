FROM prom/prometheus:v1.4.1  
MAINTAINER Marc Fournier <marc.fournier@camptocamp.com>  
  
#COPY /docker-entrypoint.sh /  
#COPY /docker-entrypoint.d/* /docker-entrypoint.d/  
#ENTRYPOINT ["/docker-entrypoint.sh"]  
ADD /prometheus.yml /etc/prometheus-config/  

