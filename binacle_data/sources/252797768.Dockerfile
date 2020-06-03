FROM alpine  
  
ADD . /  
RUN apk add --update bash \  
&& apk --update add go git bzr\  
&& REPO_PATH="github.com/Financial-Times/up-restorage" \  
&& export GOPATH=/gopath \  
&& mkdir -p $GOPATH/src/github.com/Financial-Times \  
&& ln -s ${PWD} $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get \  
&& go test \  
&& go build ${REPO_PATH} \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
EXPOSE 8080  
#CMD ./up-restorage $ARGS  

