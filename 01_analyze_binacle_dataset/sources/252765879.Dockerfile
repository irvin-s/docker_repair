FROM alpine:edge  
ENTRYPOINT ["/bin/matterbridge-plus"]  
  
COPY . /go/src/github.com/42wim/matterbridge-plus  
RUN apk update && apk add go git \  
&& cd /go/src/github.com/42wim/matterbridge-plus \  
&& export GOPATH=/go \  
&& go get \  
&& go build -o /bin/matterbridge-plus \  
&& rm -rf /go \  
&& apk del --purge git go  

