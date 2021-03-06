FROM golang:1.11-alpine as builder
RUN apk add bash ca-certificates git gcc g++ libc-dev

ARG GITCOMMIT=unknown
# E.g. GITCOMMIT=$(git rev-parse HEAD)

ARG BUILDVERSION=unknown
# E.g. BUILDVERSION=$(git rev-parse HEAD)

ARG BUILDDATE=unknown
# E.g. BUILDDATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

ARG GOPKG=github.com/fission/fission
COPY . /go/src/${GOPKG}
WORKDIR /go/src/${GOPKG}/cmd/fetcher
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -o /go/bin/fetcher \
    -gcflags=-trimpath=$GOPATH \
    -asmflags=-trimpath=$GOPATH \
    -ldflags "-X github.com/fission/fission/pkg/info.GitCommit=${GITCOMMIT} -X github.com/fission/fission/pkg/info.BuildDate=${BUILDDATE} -X github.com/fission/fission/pkg/info.Version=${BUILDVERSION}"

FROM alpine:3.4
COPY --from=builder /go/bin/fetcher /
EXPOSE 8000

ENTRYPOINT ["/fetcher"]
