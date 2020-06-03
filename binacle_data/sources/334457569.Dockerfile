FROM golang:1.11.4-alpine as builder

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh gcc musl-dev

RUN mkdir -p /go/src/github.com/census-instrumentation
WORKDIR /go/src/github.com/census-instrumentation
RUN git clone https://github.com/census-instrumentation/opencensus-service.git

WORKDIR /go/src/github.com/census-instrumentation/opencensus-service
RUN rm -rf /go/src/github.com/census-instrumentation/opencensus-service/go.sum
RUN export GO111MODULE=on && ./build_binaries.sh linux && cp bin/ocagent_linux /ocagent

FROM alpine:3.7

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh curl

WORKDIR /

COPY --from=builder /ocagent /ocagent
COPY config.yaml /config.yaml

# Expose the OpenCensus receiver port.
EXPOSE 55678/tcp 55679/tcp

CMD ["/ocagent"]
