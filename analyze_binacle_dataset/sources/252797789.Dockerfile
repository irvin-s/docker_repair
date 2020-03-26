FROM alpine:3.3  
ADD *.go /video-mapper/  
  
RUN apk add --update bash \  
&& apk --update add git bzr \  
&& apk --update add go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/video-mapper" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv video-mapper/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv video-mapper /video-mapper-app \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD [ "/video-mapper-app" ]

