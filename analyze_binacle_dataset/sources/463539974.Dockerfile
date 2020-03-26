FROM golang:1.11.8 as nodeagent_builder

ARG ARCH=amd64
ARG GO111MODULE=on

WORKDIR $GOPATH/src/github.com/supergiant/analyze/

COPY go.mod go.sum vendor $GOPATH/src/github.com/supergiant/analyze/

COPY . $GOPATH/src/github.com/supergiant/analyze/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build \
		-mod=vendor \
		-o $GOPATH/bin/analyze-nodeagent -a ./cmd/analyze-nodeagent

FROM busybox:latest
COPY --from=nodeagent_builder /go/bin/analyze-nodeagent /bin/analyze-nodeagent

ENTRYPOINT ["/bin/analyze-nodeagent"]
