FROM golang:1.11-alpine as build

WORKDIR $GOPATH/src/github.com/sakajunquality/gke-getting-started/app1
COPY main.go main.go

RUN go get -d -v ./...
RUN go install -v ./...

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=build /go/bin/app1 /usr/local/bin/app1

CMD ["app1"]
