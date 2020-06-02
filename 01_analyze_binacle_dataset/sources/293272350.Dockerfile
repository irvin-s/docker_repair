FROM golang:1.9.2

MAINTAINER RoCry <rocry@bearyinnovative.com>

RUN curl https://glide.sh/get | sh

COPY . /go/src/github.com/bearyinnovative/lili
RUN cd /go/src/github.com/bearyinnovative/lili && glide install

WORKDIR /go/src/github.com/bearyinnovative/lili/examples/lili
RUN glide install

RUN go build -o main

CMD ["./main"]