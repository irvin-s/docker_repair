# Build the manager binary
FROM golang:1.12.5 as builder

# Copy in the go src
WORKDIR /go/src/sigs.k8s.io/cluster-api-provider-exoscale
COPY pkg/    pkg/
COPY cmd/    cmd/
COPY vendor/ vendor/

# Build
ARG CGO_ENABLED=0
ARG GOOS=linux
ARG GOARCH=amd64

RUN go build -a -o /usr/local/bin/manager sigs.k8s.io/cluster-api-provider-exoscale/cmd/manager

# Copy the controller-manager into a thin image
FROM linuxkit/ca-certificates:v0.6

WORKDIR /root/
COPY --from=builder /usr/local/bin/manager .

ENTRYPOINT ["./manager"]
