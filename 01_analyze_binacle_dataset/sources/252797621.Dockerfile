FROM alpine:3.5  
COPY . /annotations-rw-rdb/  
  
RUN apk --update add go git libc-dev ca-certificates \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/annotations-rw-rdb" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& cp -r annotations-rw-rdb/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t -v ./... \  
&& go build \  
&& mv annotations-rw-rdb /annotations-rw-rdb-app \  
&& mv migrations /migrations \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/* /annotations-rw-rdb  
  
CMD [ "/annotations-rw-rdb-app" ]  

