FROM golang:1.11

WORKDIR /go/src/github.com/makotia/Matsuya-Web-API
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["Matsuya-Web-API"]
