FROM alpine  
  
ADD *.go /  
RUN apk --update add go git\  
&& ORG_PATH="github.com/Financial-Times" \  
&& REPO_PATH="${ORG_PATH}/key-ad-validator" \  
&& export GOPATH=/gopath \  
&& mkdir -p $GOPATH/src/${ORG_PATH} \  
&& ln -s ${PWD} $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get \  
&& go build ${REPO_PATH} \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
EXPOSE 8080  
CMD ["/key-ad-validator"]  
  

