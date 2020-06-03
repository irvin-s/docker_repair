FROM alpine:3.6  
COPY . /go/src/github.com/bobrik/zoidbergtcp  
  
RUN apk --update add go libc-dev && \  
GOPATH=/go go install -v github.com/bobrik/zoidbergtcp/cmd/... && \  
apk del go  
  
ENTRYPOINT ["/go/bin/zoidberg-tcp"]  

