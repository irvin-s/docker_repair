FROM prom/prometheus

EXPOSE 9090:9999

ADD prometheus.yml /etc/prometheus/
