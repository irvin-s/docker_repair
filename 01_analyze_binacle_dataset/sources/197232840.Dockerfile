FROM golang:1.5

RUN go get -v github.com/miolini/bankgo/httpapi/server
EXPOSE 14080
ENTRYPOINT ["/go/bin/server"]