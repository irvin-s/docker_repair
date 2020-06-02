FROM alpine:3.6  
  
ENV GOROOT=/usr/lib/go \  
GOPATH=/go \  
GOBIN=/go/bin \  
PATH=$PATH:$GOROOT/bin:$GOBIN  
  
RUN apk add -U git go libc-dev && \  
mkdir -p $GOPATH/src/github.com/alangibson && \  
cd $GOPATH/src/github.com/alangibson && \  
git clone https://github.com/alangibson/yesdns.git && \  
cd yesdns && \  
git checkout 0.2.0 && \  
go get -v && \  
go install github.com/alangibson/yesdns/cmd/yesdns && \  
cp $GOBIN/yesdns /usr/local/bin/ && \  
apk del git go && \  
rm -rf /go/pkg && \  
rm -rf /go/src && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /var/lib/yesdns  
VOLUME /var/lib/yesdns  
# Default HTTP port is 5380  
# By convention, the 'default' resolver is on 53  
EXPOSE 53 5380  
  
ENTRYPOINT yesdns  

