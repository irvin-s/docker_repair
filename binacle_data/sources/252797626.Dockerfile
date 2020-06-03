FROM alpine:3.4  
ADD *.go /brightcove-notifier/  
  
RUN apk add --update bash \  
&& apk --update add git bzr \  
&& apk --update add go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/brightcove-notifier" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv brightcove-notifier/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv brightcove-notifier /brightcove-notifier-app \  
&& rm -rf /brightcove-notifier \  
&& mv /brightcove-notifier-app /brightcove-notifier \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD [ "/brightcove-notifier" ]  

