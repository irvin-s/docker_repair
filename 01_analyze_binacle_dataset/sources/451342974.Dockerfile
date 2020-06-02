FROM golang

RUN go get github.com/h2so5/murcott

WORKDIR /go/src/github.com/h2so5/murcott/tangor

RUN go get . ...

RUN go build -o tangor *.go

ENTRYPOINT ./tangor
