FROM golang:1.11-alpine3.7 as builder
RUN apk add --no-cache ca-certificates git && \
    apk add --no-cache bash git openssh gcc musl-dev

WORKDIR /go/src/

ENV GO111MODULE on
COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN go build -gcflags='-N -l' -o /testcoordinator cmd/main.go

# COPY test suites
RUN cp -r testdata /

FROM alpine as release
RUN apk add --no-cache ca-certificates curl

COPY --from=builder /testcoordinator /testcoordinator
COPY --from=builder /testdata /testdata
EXPOSE 10003 10002 10001
ENTRYPOINT ["/testcoordinator"]

