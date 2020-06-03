FROM alpine:3.3  
  
COPY . /go/src/github.com/bobrik/scrappy  
  
RUN apk --update add go git && \  
GOPATH=/go go get github.com/bobrik/scrappy/... && \  
apk del go git && \  
mv /go/bin/scrappy-* /usr/bin/ && \  
rm -rf /go  
  
COPY ./docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

