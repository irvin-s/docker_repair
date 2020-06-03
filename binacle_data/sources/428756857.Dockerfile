FROM golang:1.11 as build-stage

COPY vendor /go/src
COPY ./pkg/ /go/src/github.com/toricls/ecs-taskmetadata-cloudwatch/pkg/
COPY ./taskmetadata-cloudwatch.go /in/taskmetadata-cloudwatch.go

RUN CGO_ENABLED=0 GO_PATH=/go go build -a -x -ldflags '-s' -o /out/taskmetadata-cloudwatch /in/taskmetadata-cloudwatch.go

# Using alpine:3.8
FROM alpine@sha256:46e71df1e5191ab8b8034c5189e325258ec44ea739bba1e5645cff83c9048ff1

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY --from=build-stage /out/taskmetadata-cloudwatch /

ENTRYPOINT ["/taskmetadata-cloudwatch"]
