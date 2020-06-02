FROM golang:latest 

COPY . /go/src/github.com/frostornge/ethornge
WORKDIR /go/src/github.com/frostornge/ethornge

RUN go get ./
RUN go build -o main .

CMD ["/go/src/github.com/frostornge/ethornge/main"]
