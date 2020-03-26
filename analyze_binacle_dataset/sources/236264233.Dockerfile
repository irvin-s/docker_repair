FROM golang:1-alpine

RUN apk add --no-cache git gcc libc-dev

RUN go get -u github.com/Masterminds/glide

RUN mkdir -p /go/src/github.com/iotaledger/sandbox

COPY . /go/src/github.com/iotaledger/sandbox

WORKDIR /go/src/github.com/iotaledger/sandbox

RUN glide install

RUN go build -o sandbox-server ./cmd/server
CMD ["./sandbox-server"]

EXPOSE "8080"
