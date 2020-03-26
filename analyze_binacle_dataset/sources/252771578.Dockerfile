FROM gliderlabs/alpine:3.1  
  
MAINTAINER Brian Hicks <brian@aster.is>  
  
COPY . /go/src/github.com/asteris-llc/gestalt  
RUN apk add \--update go git mercurial \  
&& cd /go/src/github.com/asteris-llc/gestalt \  
&& export GOPATH=/go \  
&& go get \  
&& go build -o /bin/gestalt \  
&& rm -rf /go \  
&& apk del --purge go git mercurial  
  
ENTRYPOINT [ "/bin/gestalt" ]  

