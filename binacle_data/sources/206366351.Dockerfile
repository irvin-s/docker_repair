FROM golang:1.8.3-alpine

ENV PORT=2005
EXPOSE 2005

ADD . /go/src/github.com/adobe-platform/feature-flipper
WORKDIR /go/src/github.com/adobe-platform/feature-flipper

RUN go build -o /feature-flipper

CMD /feature-flipper
