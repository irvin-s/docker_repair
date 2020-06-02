FROM alpine  
  
COPY . /go/src/auto-stats  
  
ENV GOROOT=/usr/lib/go \  
GOPATH=/go \  
GOBIN=/go/bin \  
PATH=$PATH:$GOROOT/bin:$GOPATH/bin  
  
RUN apk add -U git ca-certificates go build-base && \  
go get -v auto-stats && \  
apk del git go build-base && \  
rm -rf /go/src /go/pkg /var/cache/apk/  
  
ENTRYPOINT ["/go/bin/auto-stats"]  

