FROM alpine:3.5  
  
RUN mkdir -p /tmp/go && \  
apk add --no-cache git go libc-dev && \  
export GOPATH=/tmp/go && \  
go get -v github.com/bemasher/rtlamr && \  
cp /tmp/go/bin/* /usr/local/bin/ && \  
apk del git go libc-dev && \  
rm -rf /tmp/go /usr/lib/go  
  
USER nobody  

