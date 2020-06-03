FROM golang:1.8-alpine  
  
RUN mkdir -p "$GOPATH/src"  
  
ADD . "$GOPATH/src/github.com/Financial-Times/v1-metadata-publisher"  
  
WORKDIR "$GOPATH/src/github.com/Financial-Times/v1-metadata-publisher"  
  
RUN apk --no-cache --virtual .build-dependencies add git \  
&& apk --no-cache --upgrade add ca-certificates \  
&& update-ca-certificates --fresh \  
&& apk --no-cache --upgrade add openssh \  
&& cd $GOPATH/src/github.com/Financial-Times/v1-metadata-publisher \  
&& go get ./... \  
&& go build \  
&& apk del .build-dependencies \  
&& rm -rf $GOPATH/src $GOPATH/pkg /usr/local/go  
  
EXPOSE 8080  
CMD ["v1-metadata-publisher"]

