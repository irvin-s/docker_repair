FROM golang:1.10

WORKDIR /go/src/github.com/munisystem/hifumi
COPY . .
RUN go build -o bin/hifumi

CMD ["bin/hifumi"]
