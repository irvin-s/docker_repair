FROM golang:1.11

LABEL version=0.1
LABEL name=go_revel

ENV GOPATH $GOPATH:/go/src 

#RUN apt-get update && \
#    apt-get upgrade -y

RUN go get github.com/revel/revel && \
    go get github.com/revel/cmd/revel && \
    go get github.com/jinzhu/gorm && \
    go get github.com/go-sql-driver/mysql

RUN mkdir /go/src/myapp

EXPOSE 9000
