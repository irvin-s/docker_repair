FROM alpine:3.4  
ADD . /source/  
ADD ./api/ /api/  
  
RUN apk add --update bash \  
&& apk --update add git go \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/up-coco-admin/" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv /source/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get ./... \  
&& go install ${REPO_PATH} \  
&& mv ${GOPATH}/bin/up-coco-admin / \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
EXPOSE 8080  
CMD [ "/up-coco-admin" ]  

