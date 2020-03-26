FROM golang:1.11

RUN go get -u github.com/golang/dep/...

WORKDIR /go/src/github.com/mathetake/doogle

COPY Gopkg.lock ./
COPY Gopkg.toml ./

RUN dep ensure -v -vendor-only=true

COPY . .
RUN dep ensure -v
RUN go build
