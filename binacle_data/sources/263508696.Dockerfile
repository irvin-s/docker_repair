FROM        quay.io/prometheus/busybox:latest
MAINTAINER  Ferran Rodenas <frodenas@gmail.com>

COPY grafana_exporter /bin/grafana_exporter

ENTRYPOINT ["/bin/grafana_exporter"]
EXPOSE     9261