FROM golang:1.10.3

RUN go get -u github.com/Masterminds/glide
RUN mkdir -p /go/src/github.com/netlify && chmod -R 777 /go
