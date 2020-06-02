FROM golang:1.10.2

WORKDIR /go/src/github.com/sqlabble/sqlabble
RUN go get -u \
      github.com/golang/dep/...
COPY . .
RUN dep ensure
RUN go install ./cmd/...

CMD sh test.sh
