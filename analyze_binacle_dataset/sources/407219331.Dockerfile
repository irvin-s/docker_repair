FROM jaegertracing/jaeger-query:latest

FROM alpine
COPY --from=0 /go/bin/query-linux /go/bin/query-linux

ENV SPAN_STORAGE_TYPE grpc-plugin
ENV GRPC_STORAGE_PLUGIN_BINARY /go/bin/jaeger-influxdb-linux

COPY ./cmd/jaeger-influxdb/jaeger-influxdb-linux /go/bin/jaeger-influxdb-linux

ENTRYPOINT /go/bin/query-linux
