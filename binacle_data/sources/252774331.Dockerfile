FROM golang:1.9-alpine  
  
RUN apk update && \  
apk add --no-cache \  
bash git && \  
rm -rf /var/cache /etc/apk/cache/*  
  
# Install the vendoring tool  
RUN go get -u \  
github.com/kardianos/govendor && \  
rm -rf /go/src/github.com  
  
ADD scripts/init.sh /init.sh  
ADD scripts/sync_deps.sh /sync_deps.sh  
ADD scripts/test.sh /test.sh  

