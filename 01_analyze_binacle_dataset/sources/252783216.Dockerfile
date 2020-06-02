FROM alpine:3.2  
MAINTAINER Brian Glogower <bglogower@docker.com>  
EXPOSE 9111  
ENTRYPOINT [ "/bin/heka_dashboard_exporter" ]  
  
ENV GOPATH /go  
ENV APPPATH $GOPATH/src/github.com/docker-infra/heka_dashboard_exporter  
COPY . $APPPATH  
RUN apk add --update -t build-deps go git mercurial \  
&& cd $APPPATH && go get -d && go build -o /bin/heka_dashboard_exporter \  
&& apk del --purge build-deps && rm -rf $GOPATH  

