FROM golang:1.9-alpine3.6  
MAINTAINER Alexey Kovrizhkin <lekovr+dopos@gmail.com>  
  
ENV NARRA_VERSION 0.1  
WORKDIR /go/src/github.com/dopos/narra  
COPY . .  
  
RUN apk add --no-cache git curl  
RUN go get -u github.com/jteeuwen/go-bindata/...  
RUN go get -u github.com/elazarl/go-bindata-assetfs/...  
  
RUN go-wrapper download  
RUN CGO_ENABLED=0 GOOS=linux go build -a -o narra  
  
FROM scratch  
  
WORKDIR /  
COPY \--from=0 /go/src/github.com/dopos/narra/narra .  
# Need for SSL  
COPY \--from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/  
  
EXPOSE 8080  
ENTRYPOINT ["/narra"]  
  

