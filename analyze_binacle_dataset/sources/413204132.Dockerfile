FROM golang:1.12

WORKDIR /go/src/github.com/polaris-project/go-polaris
COPY . .

RUN go get -d -v ./...

CMD go run main.go