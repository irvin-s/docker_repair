FROM golang:1.10.3
COPY . /go/src/github.com/storageos/go-cli
WORKDIR /go/src/github.com/storageos/go-cli
RUN make build

FROM alpine:3.7
RUN apk --no-cache add ca-certificates
COPY --from=0 /go/src/github.com/storageos/go-cli/cmd/storageos/storageos /storageos
RUN ln -s /storageos /usr/local/bin/storageos
ENTRYPOINT ["storageos"]
