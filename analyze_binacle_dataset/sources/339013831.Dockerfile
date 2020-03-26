FROM        quay.io/prometheus/busybox:latest
LABEL maintainer "Stackdriver Engineering <engineering@stackdriver.com>"

COPY prometheus                             /bin/prometheus
COPY promtool                               /bin/promtool

RUN mkdir -p /prometheus && \
    chown -R nobody:nogroup /prometheus

USER       nobody
EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml" ]
