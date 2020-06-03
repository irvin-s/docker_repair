FROM alpine:3.3  
ADD *.go /up-queue-sender/  
  
RUN apk add --update bash \  
&& apk --update add git bzr \  
&& apk --update add go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/up-queue-sender" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv up-queue-sender/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv up-queue-sender /app \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD [ "/app" ]

