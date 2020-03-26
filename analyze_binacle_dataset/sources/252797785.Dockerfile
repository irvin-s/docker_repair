FROM alpine:3.3  
ADD *.go /v1-metadata-republisher/  
  
RUN apk add --update bash \  
&& apk --update add git bzr \  
&& apk --update add go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/v1-metadata-republisher" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv v1-metadata-republisher/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv v1-metadata-republisher /app \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD [ "/bin/bash" ]

