FROM alpine:3.4  
VOLUME /upload  
  
ADD . /source/  
RUN apk add --update bash git go ca-certificates \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/neo4j-hot-backup/" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv /source/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get ./... \  
&& go install ${REPO_PATH} \  
&& mv ${GOPATH}/bin/neo4j-hot-backup / \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD ["/neo4j-hot-backup", "backup"]  

