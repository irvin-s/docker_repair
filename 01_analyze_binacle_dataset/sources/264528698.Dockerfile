FROM grafana/grafana:latest
RUN mkdir -p /var/lib/grafana/dashboards
COPY provisioning /etc/grafana/provisioning/
COPY dashboards /var/lib/grafana/dashboards/
