FROM golang:1.10
RUN go get -v github.com/mmatczuk/go-http-tunnel/cmd/tunneld
ENTRYPOINT /go/bin/tunneld
