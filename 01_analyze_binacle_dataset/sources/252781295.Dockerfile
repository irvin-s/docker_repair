FROM prom/prometheus:v2.2.1  
COPY prometheus.yml alert.rules /etc/prometheus/  

