FROM  quay.io/prometheus/busybox:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

COPY influxdb_exporter /bin/influxdb_exporter

USER        nobody
EXPOSE      9122
ENTRYPOINT  [ "/bin/influxdb_exporter" ]
