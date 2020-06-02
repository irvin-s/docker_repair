FROM golang:1.7.1-alpine

RUN apk update && apk upgrade && \
    apk add --no-cache git

RUN go get github.com/docker/docker/api/types
RUN go get github.com/docker/docker/client

RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 

RUN go build -o main .

ENTRYPOINT ["/app/main"]