FROM alpine:3.5

MAINTAINER brunopsoares

RUN apk --no-cache add \
      curl \
      python \
      py-pip \
    && pip install prometheus-couchbase-exporter \
    && rm -rf /var/cache/apk/*

# runtime environment variables
ENV COUCHBASE_HOST="127.0.0.1" \
    COUCHBASE_PORT="8091" \
    COUCHBASE_USERNAME="" \
    COUCHBASE_PASSWORD="" \
    PROMETHEUS_PORT="9420"

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD prometheus-couchbase-exporter -c http://${COUCHBASE_HOST}:${COUCHBASE_PORT} -p ${PROMETHEUS_PORT}
