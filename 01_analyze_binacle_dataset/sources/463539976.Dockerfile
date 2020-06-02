FROM golang:1.11.8 as job_builder

ARG ARCH=amd64
ARG GO111MODULE=on

WORKDIR $GOPATH/src/github.com/supergiant/analyze/

COPY go.mod go.sum vendor $GOPATH/src/github.com/supergiant/analyze/

COPY . $GOPATH/src/github.com/supergiant/analyze/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build \
		-mod=vendor \
		-o $GOPATH/bin/analyze-registry-job -a ./cmd/analyze-registry-job

FROM busybox:latest
COPY --from=job_builder /go/bin/analyze-registry-job /bin/analyze-registry-job

ENTRYPOINT ["/bin/analyze-registry-job"]
