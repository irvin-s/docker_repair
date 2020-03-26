# Build the manager binary
FROM golang:1.10.3 as builder

# Copy in the go src
WORKDIR /go/src/github.com/asauber/cluster-api-provider-linode
COPY pkg/    pkg/
COPY cmd/    cmd/
COPY vendor/ vendor/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o manager github.com/asauber/cluster-api-provider-linode/cmd/manager

# kubeadm (for pre-generating cluster tokens)
FROM ubuntu:latest as kubeadm
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sSL https://dl.k8s.io/release/v1.11.3/bin/linux/amd64/kubeadm > /usr/bin/kubeadm
RUN chmod a+rx /usr/bin/kubeadm

# Copy the controller-manager into a thin image
FROM ubuntu:latest
WORKDIR /root/
COPY --from=builder /go/src/github.com/asauber/cluster-api-provider-linode/manager .
ENTRYPOINT ["./manager"]
