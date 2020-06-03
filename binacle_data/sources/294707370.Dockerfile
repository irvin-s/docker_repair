FROM golang:1.9 AS builder

ADD sidecar.go /tmp/
WORKDIR /tmp
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -ldflags '-w -s' -a -installsuffix cgo -o \
    mcrouter_sidecar sidecar.go

FROM scratch

COPY --from=builder /tmp/mcrouter_sidecar /mcrouter_sidecar

ENTRYPOINT ["./mcrouter_sidecar"]
