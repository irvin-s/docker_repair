FROM golang:1.9.2-alpine

RUN apk add --no-cache --update alpine-sdk

COPY . /go/src/github.com/coreos/kubecsr
RUN cd /go/src/github.com/coreos/kubecsr && make bin/kube-etcd-signer-server

FROM alpine:3.4
COPY --from=0 /go/src/github.com/coreos/kubecsr/bin/kube-etcd-signer-server /usr/local/bin/kube-etcd-signer-server

ENTRYPOINT ["kube-etcd-signer-server"]
