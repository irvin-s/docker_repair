FROM alpine:3.7  
ENTRYPOINT ["/bin/garden-universe"]  
  
COPY . /go/src/github.com/afritzler/garden-universe  
RUN apk --no-cache add -t build-deps build-base go git \  
&& apk --no-cache add ca-certificates \  
&& cd /go/src/github.com/afritzler/garden-universe \  
&& export GOPATH=/go \  
&& go build -o /bin/garden-universe \  
&& rm -rf /go \  
&& apk del --purge build-deps

