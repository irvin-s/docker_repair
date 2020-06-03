FROM golang:1.7-alpine  
  
ENTRYPOINT /go/bin/gosample  
  
WORKDIR $GOPATH/src/github.com/lcacciagioni/gosample  
  
RUN apk add --no-cache curl git && \  
curl https://glide.sh/get | sh  
  
EXPOSE 9000  
ADD . $GOPATH/src/github.com/lcacciagioni/gosample  
  
RUN glide install && go build && go install

