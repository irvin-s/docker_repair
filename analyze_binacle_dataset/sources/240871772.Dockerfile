FROM golang:latest
ADD go /go
WORKDIR /go/src/capter
RUN go get
RUN CGO_ENABLED=0 go build
WORKDIR /go/bin
EXPOSE 1234
CMD /go/bin/capter