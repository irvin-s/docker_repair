FROM alpine:3.4  
MAINTAINER Wantedly, Inc. Infrastructure Team <dev@wantedly.com>  
  
ENV GOPATH /go  
  
COPY . /go/src/github.com/wantedly/kubenetes-slack  
  
RUN apk add \--no-cache --update \--virtual=build-deps curl git go make \  
&& cd /go/src/github.com/wantedly/kubenetes-slack \  
&& go get ./... \  
&& make \  
&& cp bin/kubenetes-slack /kubenetes-slack \  
&& cd / \  
&& rm -rf /go \  
&& apk del build-deps  
  
EXPOSE 8080  
  
ENTRYPOINT ["/kubenetes-slack"]  

