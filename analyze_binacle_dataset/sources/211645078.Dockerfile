FROM golang:1.10
RUN mkdir -p /go/src/github.com/malnick/cryptorious
WORKDIR /go/src/github.com/malnick/cryptorious
COPY . .  
