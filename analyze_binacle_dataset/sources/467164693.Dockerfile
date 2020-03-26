FROM golang:1.11.2-alpine

ENV GO111MODULE on
ARG branch="master"

RUN apk --update add gcc git musl-dev

RUN mkdir -p /go/src/github.com/m0t0k1ch1

WORKDIR /go/src/github.com/m0t0k1ch1
RUN git clone -b $branch https://github.com/m0t0k1ch1/more-minimal-plasma-chain.git

WORKDIR /go/src/github.com/m0t0k1ch1/more-minimal-plasma-chain
RUN go install -v ./...

ENTRYPOINT ["more-minimal-plasma-chain"]
