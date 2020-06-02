FROM golang:1.10-alpine as builder
WORKDIR /go/src/github.com/Hendra-Huang/go-standard-layout
RUN apk add --no-cache make
COPY . /go/src/github.com/Hendra-Huang/go-standard-layout
RUN make build

FROM alpine:3.6 as myappserver
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/Hendra-Huang/go-standard-layout/bin/ /usr/local/bin/
EXPOSE 5555
ENTRYPOINT ["/usr/local/bin/myappserver"]
