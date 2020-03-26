FROM jaegertracing/jaeger-agent:latest

FROM alpine
COPY --from=0 /go/bin/agent-linux /go/bin/agent-linux
