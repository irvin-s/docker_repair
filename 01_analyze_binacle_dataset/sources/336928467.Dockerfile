FROM golang:1.9.2-alpine

RUN apk add --no-cache --update alpine-sdk

COPY . /go/src/github.com/coreos/kubecsr
RUN cd /go/src/github.com/coreos/kubecsr && make bin/kube-client-agent

FROM alpine:3.4
COPY --from=0 /go/src/github.com/coreos/kubecsr/bin/kube-client-agent /usr/local/bin/kube-client-agent

ENTRYPOINT ["kube-client-agent"]
