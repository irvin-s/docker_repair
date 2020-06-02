FROM golang:1.9-alpine  
  
RUN apk add --no-cache \  
git  
  
RUN go get -u github.com/letsencrypt/pebble/...  
  
WORKDIR /go/src/github.com/letsencrypt/pebble  
  
RUN go install ./...  
  
ENV PEBBLE_VA_NOSLEEP=1 \  
PEBBLE_WFE_NONCEREJECT=0  
CMD ["/go/bin/pebble"]  

