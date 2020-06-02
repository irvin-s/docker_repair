FROM golang:1.8.3-alpine3.6

COPY . /app

RUN sh -c 'cd /app \
 && apk add --update git \
 && go get github.com/gin-gonic/gin \
 && go get github.com/gin-contrib/cors \
 && go get github.com/parnurzeal/gorequest \
 && go build main.go'

CMD ["/app/main"]

