FROM golang:1.11.5-alpine

WORKDIR $GOPATH/src/github.com/sakajunquality/gke-getting-started/app3
COPY main.go main.go

RUN go get -d -v ./...
RUN go install -v ./...

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/app3 /usr/local/bin/app3

CMD ["app3"]
