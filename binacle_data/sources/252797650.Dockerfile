FROM alpine:3.4  
COPY . /coco-traffic-analyser/  
  
RUN apk --update add git bzr go g++ libpcap-dev \  
&& export GOPATH=/gopath \  
&& REPO_PATH="github.com/Financial-Times/coco-traffic-analyser" \  
&& mkdir -p $GOPATH/src/${REPO_PATH} \  
&& mv /coco-traffic-analyser/* $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t ./... \  
&& go build \  
&& mv coco-traffic-analyser /coco-traffic-analyser-app \  
&& rm -rf /coco-traffic-analyser \  
&& mv /coco-traffic-analyser-app /coco-traffic-analyser \  
&& apk del go git bzr \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD exec /coco-traffic-analyser  

