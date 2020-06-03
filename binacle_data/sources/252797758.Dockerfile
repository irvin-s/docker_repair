FROM alpine:3.5  
COPY . .git /unpublish-content-notifier/  
  
RUN apk --update add git go libc-dev ca-certificates \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/unpublish-content-notifier" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& cp -r unpublish-content-notifier/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t -v ./... \  
&& go build \  
&& mv unpublish-content-notifier /unpublish-content-notifier-app \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/* /unpublish-content-notifier  
  
CMD [ "/unpublish-content-notifier-app" ]  

