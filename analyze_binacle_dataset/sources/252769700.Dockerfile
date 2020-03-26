FROM golang:1.7.1-alpine  
  
RUN apk --update add git ca-certificates && rm -rf /var/cache/apk/*  
  
ARG VERSION  
WORKDIR /app  
  
COPY . /go/src/github.com/arkan/cloudflare-ddns  
  
WORKDIR /go/src/github.com/arkan/cloudflare-ddns  
  
RUN go get -v ./... && \  
go build ./cmd/cloudflare-ddns  
  
CMD /go/bin/cloudflare-ddns  
  

