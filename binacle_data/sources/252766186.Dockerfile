FROM gliderlabs/alpine:3.1  
ENTRYPOINT ["/bin/auditor"]  
  
COPY . /go/src/github.com/aatarasoff/auditor  
RUN apk-install -t build-deps go git mercurial \  
&& cd /go/src/github.com/aatarasoff/auditor \  
&& export GOPATH=/go \  
&& go get \  
&& go build -ldflags "-X main.Version $(cat VERSION)" -o /bin/auditor \  
&& rm -rf /go \  
&& apk del --purge build-deps  

