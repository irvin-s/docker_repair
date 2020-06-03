FROM        quay.io/prometheus/busybox:latest
MAINTAINER  Samuel BERTHE <samuel.berthe@iadvize.com>

COPY traefik_exporter /bin/traefik_exporter

EXPOSE     9000
ENTRYPOINT [ "/bin/traefik_exporter" ]
