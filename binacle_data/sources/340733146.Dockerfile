FROM golang:1.5

WORKDIR /go/src/app
COPY . /go/src/app

RUN cc resources/zombie.c -o resources/zombie
RUN go build bifurcate.go
ENTRYPOINT ["/go/src/app/bifurcate", "resources/demo.json"]
