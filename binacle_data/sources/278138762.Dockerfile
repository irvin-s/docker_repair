FROM prom/prometheus AS prometheus

FROM alpine:3.8

COPY --from=prometheus / /

RUN apk add --no-cache bash python3 ca-certificates tzdata \
    && pip3 install s3cmd \
    && rm -fR /etc/periodic

COPY rootfs /

RUN chmod 0777 /home

USER nobody

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT ["/init.sh"]
CMD        [ "--config.file=/etc/prometheus/prometheus.yml", \
             "--storage.tsdb.path=/prometheus", \
             "--web.console.libraries=/usr/share/prometheus/console_libraries", \
             "--web.console.templates=/usr/share/prometheus/consoles" ]
