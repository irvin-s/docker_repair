FROM duffqiu/golang:latest  
MAINTAINER duffqiu@gmail.com  
  
  
#build skydns  
RUN go get github.com/skynetservices/skydns  
WORKDIR $GOPATH/src/github.com/skynetservices/skydns  
RUN go build -v  
  
ENV ETCD_MACHINES=http://127.0.0.1:4001 SKYDNS_DOMAIN=cluster.duffqiu.org  
  
EXPOSE 53  
ENTRYPOINT ["/root/go/bin/skydns"]  
  

