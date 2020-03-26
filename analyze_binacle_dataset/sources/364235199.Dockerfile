FROM golang:1.5

ADD . /go/src/github.com/golang/gamexg/TcpRoute2/httpProxy

ADD httpProxy-wrapper /usr/local/bin/

RUN go get github.com/golang/gamexg/TcpRoute2/httpProxy \
    && chmod a+x /usr/local/bin/httpProxy-wrapper

USER nobody

CMD ["httpProxy"]
