FROM alpine:edge  
  
EXPOSE 8086  
RUN mkdir /go  
ENV GOPATH /go  
ENV GOBIN /go/bin  
ENV INFLUXDB_RELAY github.com/influxdata/influxdb-relay  
WORKDIR $GOPATH/src/$INFLUXDB_RELAY/  
COPY . $GOPATH/src/$INFLUXDB_RELAY/  
COPY influxdb-relay.toml /root/  
RUN set -ex && \  
apk add --no-cache --virtual .build-deps \  
git \  
go \  
build-base && \  
go get github.com/sparrc/gdm && \  
/go/bin/gdm restore && \  
go install main.go && \  
apk del .build-deps && \  
rm -rf $GOPATH/pkg && \  
rm -rf $GOPATH/src && \  
rm -rf /usr && \  
rm -rf $GOPATH/bin/gdm && \  
mv $GOPATH/bin/main $GOPATH/bin/influxdb-relay  
WORKDIR /root  
CMD /go/bin/influxdb-relay -config influxdb-relay.toml  

