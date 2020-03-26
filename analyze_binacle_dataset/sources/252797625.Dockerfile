FROM alpine:3.3  
ADD *.go /brightcove-metadata-notifier/  
  
RUN apk add --update bash \  
&& apk --update add git bzr \  
&& apk --update add go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/brightcove-metadata-notifier" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv brightcove-metadata-notifier/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv brightcove-metadata-notifier /brightcove-metadata-notifier-app \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD [ "/brightcove-metadata-notifier-app" ]  

