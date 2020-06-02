FROM prom/prometheus:0.18.0
COPY ./alert.rules    /etc/prometheus/alert.rules
COPY ./prometheus.yml /etc/prometheus/prometheus.yml
