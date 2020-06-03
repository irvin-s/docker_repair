FROM alpine:3.4  
ADD *.go /  
RUN apk update \  
&& apk add bash git go ca-certificates \  
&& ORG_PATH="github.com/Financial-Times" \  
&& REPO_PATH="${ORG_PATH}/up-restutil" \  
&& export GOPATH=/gopath \  
&& mkdir -p $GOPATH/src/${ORG_PATH} \  
&& ln -s ${PWD} $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t \  
&& go test \  
&& go build ${REPO_PATH} \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD ./up-restutil \  
"sync-ids" \  
\--retries=$RETRIES \  
\--sourceFile=$SOURCE_FILE \  
\--destFile=$DEST_FILE \  
\--concurrency=$CONCURRENCY \  
$SOURCE_URL \  
$DEST_URL  

