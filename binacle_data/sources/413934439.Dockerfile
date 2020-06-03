FROM daocloud.io/library/golang:latest

WORKDIR /app/gopath/rddlock
ENV GOPATH /app/gopath

RUN go get github.com/everfore/rddlock/test

EXPOSE 8080

CMD ["/app/gopath/bin/test"]


