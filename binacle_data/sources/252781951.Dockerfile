FROM gliderlabs/alpine:3.4  
MAINTAINER chrisurwin  
  
EXPOSE 9777  
  
RUN addgroup cleanup \  
&& adduser -S -G cleanup cleanup  
  
COPY ./*.go /go/src/github.com/chrisurwin/rancher-rebalancer/  
  
RUN apk --update add ca-certificates \  
&& apk --update add \--virtual build-deps go git \  
&& cd /go/src/github.com/chrisurwin/rancher-rebalancer \  
&& GOPATH=/go go get \  
&& GOPATH=/go go build -o /bin/rancher-rebalancer \  
&& apk del --purge build-deps \  
&& rm -rf /go/bin /go/pkg /var/cache/apk/*  
  
USER cleanup  
  
ENTRYPOINT [ "/bin/rancher-rebalancer" ]

