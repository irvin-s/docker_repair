FROM golang:1.7-alpine  
  
ENV GO_PROEJCT_PATH "github.com/daehyeok/nuvi"  
  
COPY . $GOPATH/src/$GO_PROEJCT_PATH  
#for docker compose  
RUN apk update && apk upgrade && apk add make git  
RUN go get github.com/maxcnunes/waitforit  
  
WORKDIR $GOPATH/bin  
  
RUN go build $GO_PROEJCT_PATH  
  
CMD ["nuvi"]  

