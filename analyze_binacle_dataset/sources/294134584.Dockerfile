FROM golang:1.8

RUN mkdir -p /go/src/app
WORKDIR /go/src/app
COPY . /go/src/app

ENV CGO_ENABLED=0

RUN go-wrapper download
RUN go-wrapper install

CMD ["go-wrapper", "run"]