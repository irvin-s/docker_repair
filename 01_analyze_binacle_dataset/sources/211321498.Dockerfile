FROM golang:1.8-alpine

RUN mkdir -p /go/src/github.com/hairyhenderson/restdemo
WORKDIR /go/src/github.com/hairyhenderson/restdemo
COPY . /go/src/github.com/hairyhenderson/restdemo

# build the service
RUN go build -ldflags "-w -s"

CMD [ "/go/src/github.com/hairyhenderson/restdemo/restdemo" ]
