FROM golang:1.10 as dep
RUN go get -u github.com/golang/dep/cmd/dep github.com/alecthomas/gometalinter \
    && gometalinter --install

FROM golang:1.10 as builder
COPY --from=dep /go/bin/dep /go/bin/dep

WORKDIR /go/src/github.com/MYOB-Technology/ops-kube-alerting-rules-operator
COPY . /go/src/github.com/MYOB-Technology/ops-kube-alerting-rules-operator

RUN dep ensure -v
RUN go test ./...
ARG VERSION=latest

RUN CGO_ENABLED=0 go build -o /build/alerting-rules-operator -ldflags "-X main.version=$VERSION" -v

FROM scratch
COPY --from=builder /build/alerting-rules-operator /app

ENTRYPOINT [ "/app", "--logtostderr=true"]
