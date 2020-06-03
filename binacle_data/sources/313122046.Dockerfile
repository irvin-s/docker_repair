FROM golang:1.9 AS builder
WORKDIR /go/src/github.com/phoracek/kubetron/
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
COPY . .
RUN dep ensure --vendor-only
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/kubetron-deviceplugin github.com/phoracek/kubetron/cmd/deviceplugin

FROM fedora:27
RUN dnf install -y openvswitch iproute
COPY --from=builder /bin/kubetron-deviceplugin /bin/kubetron-deviceplugin
COPY cmd/deviceplugin/attach-pod /bin/attach-pod
ENTRYPOINT ["/bin/kubetron-deviceplugin"]
