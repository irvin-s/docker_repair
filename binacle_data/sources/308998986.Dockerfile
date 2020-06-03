# BUILDER
FROM golang:1.10 AS builder
ARG SERVICE=ion
COPY . /go/src/github.com/lawrencegripper/ion
WORKDIR /go/src/github.com/lawrencegripper/ion/cmd/$SERVICE
RUN VERSION=$(cat VERSION) \
    && GIT_COMMIT=$(git rev-parse HEAD) \
    && BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
    && GO_VERSION=$(go version | awk '{print $3}') \
    && CGO_ENABLED=0 GOOS=linux go build --ldflags "-w -s \
        -X github.com/lawrencegripper/ion/cmd/ion/version.BaseVersion=${VERSION} \
        -X github.com/lawrencegripper/ion/cmd/ion/version.BaseGitCommit=${GIT_COMMIT} \
        -X github.com/lawrencegripper/ion/cmd/ion/version.BaseBuildDate=${BUILD_DATE} \
        -X github.com/lawrencegripper/ion/cmd/ion/version.BaseGoVersion=${GO_VERSION}" \
        -a -installsuffix cgo -o /go/bin/$SERVICE

# RUNNER
FROM alpine:3.7
ARG SERVICE=ion
RUN apk --no-cache --update add \
    ca-certificates
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/$SERVICE .
COPY --from=builder /go/src/github.com/lawrencegripper/ion/configs ../etc

# it does accept the variable $SERVICE
ENTRYPOINT ["ion"]
