FROM golang:1.5

RUN go get -v github.com/miolini/bankgo/rpc/server
EXPOSE 14090
ENTRYPOINT ["/go/bin/server"]