FROM golang:1.7-alpine3.5  
RUN mkdir -p "$GOPATH/src"  
  
COPY . "$GOPATH/src/load-replicator"  
COPY fallbackInput/* /fallbackInput/  
  
WORKDIR "$GOPATH/src/load-replicator"  
  
RUN apk --no-cache --virtual .build-dependencies add git \  
&& apk --no-cache --upgrade add ca-certificates \  
&& update-ca-certificates --fresh \  
&& git config --global http.https://gopkg.in.followRedirects true \  
&& cd $GOPATH/src/load-replicator \  
&& go-wrapper download \  
&& go-wrapper install \  
&& apk del .build-dependencies \  
&& rm -rf $GOPATH/src $GOPATH/pkg /usr/local/go \  
&& cd $GOPATH \  
&& mkdir -p $GOPATH/src/load-replicator/urls \  
&& mv /fallbackInput $GOPATH/src/load-replicator/  
  
CMD ["go-wrapper", "run"]

