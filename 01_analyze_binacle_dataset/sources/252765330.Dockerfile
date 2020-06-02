FROM alpine:latest  
MAINTAINER louis@systemli.org  
  
EXPOSE 9449  
ENV GOPATH /go  
ENV APPPATH $GOPATH/src/github.com/0x46616c6b/connectivity_exporter  
COPY . $APPPATH  
RUN apk add --update -t build-deps go git mercurial libc-dev gcc libgcc \  
&& cd $APPPATH && go get -d && go build -o /connectivity_exporter \  
&& apk del --purge build-deps && apk add ca-certificates && rm -rf $GOPATH  
  
ENTRYPOINT ["/connectivity_exporter"]  

