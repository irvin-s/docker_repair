FROM golang:1-alpine  
  
RUN apk add \--update git make gcc libc-dev && \  
rm -rf /var/cache/apk/* && \  
go get bosun.org/cmd/bosun && \  
cd /go/src/bosun.org/cmd/bosun && \  
go build && \  
mv ./bosun /usr/local/bin && \  
apk del git make gcc libc-dev && \  
rm -rf /go/pkg && \  
rm -rf /go/src  
  

