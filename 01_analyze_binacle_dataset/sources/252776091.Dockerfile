FROM alpine:3.1  
  
ADD . /go/src/github.com/bobrik/logstasher  
  
RUN apk add \--update go && \  
GOPATH=/go go get github.com/bobrik/logstasher/cmd/logstasher && \  
apk del go && \  
mv /go/bin/logstasher /bin/logstasher && \  
mv /go/src/github.com/bobrik/logstasher/docker.sh /docker.sh && \  
rm -rf /go  
  
ENTRYPOINT ["/docker.sh"]  

