FROM jaegertracing/all-in-one:latest

FROM alpine
COPY --from=0 /go/bin/all-in-one-linux /go/bin/all-in-one-linux

ENV SPAN_STORAGE_TYPE grpc-plugin
ENV GRPC_STORAGE_PLUGIN_BINARY /go/bin/jaeger-influxdb-linux

COPY ./cmd/jaeger-influxdb/jaeger-influxdb-linux /go/bin/jaeger-influxdb-linux

ENTRYPOINT /go/bin/all-in-one-linux
