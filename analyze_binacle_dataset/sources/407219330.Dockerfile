FROM jaegertracing/jaeger-collector:latest

FROM alpine
COPY --from=0 /go/bin/collector-linux /go/bin/collector-linux

ENV SPAN_STORAGE_TYPE grpc-plugin
ENV GRPC_STORAGE_PLUGIN_BINARY /go/bin/jaeger-influxdb-linux

COPY ./cmd/jaeger-influxdb/jaeger-influxdb-linux /go/bin/jaeger-influxdb-linux

ENTRYPOINT /go/bin/collector-linux
