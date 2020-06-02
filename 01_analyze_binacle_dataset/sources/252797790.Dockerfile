FROM alpine  
  
ADD *.go /  
RUN apk add --update bash \  
&& apk --update add go git\  
&& ORG_PATH="github.com/Financial-Times" \  
&& REPO_PATH="${ORG_PATH}/vulcan-config-builder" \  
&& export GOPATH=/gopath \  
&& mkdir -p $GOPATH/src/${ORG_PATH} \  
&& ln -s ${PWD} $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get \  
&& go build ${REPO_PATH} \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD ["/vulcan-config-builder"]  
  

