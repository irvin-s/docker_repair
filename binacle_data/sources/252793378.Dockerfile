FROM prom/prometheus:v1.5.2  
MAINTAINER Dan <i@shanhh.com>  
  
ADD prometheus.yml /etc/prometheus/  
EXPOSE 9090  

