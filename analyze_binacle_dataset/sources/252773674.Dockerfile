FROM alpine:edge  
  
ENV GOPATH /go  
ENV GOREPO github.com/allen13/kube-speed  
RUN mkdir -p $GOPATH/src/$GOREPO  
COPY . $GOPATH/src/$GOREPO  
WORKDIR $GOPATH/src/$GOREPO  
  
RUN set -ex \  
&& apk add --no-cache --virtual .build-deps \  
git \  
go \  
build-base \  
&& go build -o kube-speed cmd/kube-speed/main.go \  
&& apk del .build-deps \  
&& rm -rf $GOPATH/pkg  
  
EXPOSE 1595  
CMD ["./kube-speed", "server"]  

