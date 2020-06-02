FROM  quay.io/prometheus/busybox:latest
LABEL maintainer="The KubeVault Authors <hello@appscode.com>"

COPY vault_exporter /bin/vault_exporter

RUN mkdir -p /conf
COPY vault-mapping /conf/vault-mapping

USER        nobody
EXPOSE      9102 9125 9125/udp
HEALTHCHECK CMD wget --spider -S "http://localhost:9102/metrics" -T 60 2>&1 || exit 1
ENTRYPOINT  [ "/bin/vault_exporter", "--statsd.mapping-config=/conf/vault-mapping" ]
