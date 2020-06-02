FROM golang:1.6.0-alpine
RUN apk add --no-cache --virtual .build-deps git make
EXPOSE 8101 8101
WORKDIR /go/src/github.com/stratio/paas-oauth
COPY . /go/src/github.com/stratio/paas-oauth
RUN make
