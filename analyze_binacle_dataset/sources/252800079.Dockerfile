FROM alpine:3.3  
MAINTAINER dingmingk <dingmingk@gmail.com>  
  
ARG MIRROR=https://github.com/coreos/etcd/releases/download  
ARG VERSION=2.3.5  
LABEL name="etcd" version=$VERSION  
  
RUN apk add --update ca-certificates openssl tar \  
&& wget $MIRROR/v$VERSION/etcd-v$VERSION-linux-amd64.tar.gz \  
&& tar zxf etcd-v$VERSION-linux-amd64.tar.gz \  
&& mv etcd-v$VERSION-linux-amd64/etcd* /bin/ \  
&& apk del --purge tar openssl \  
&& rm -Rf etcd-v$VERSION-linux-amd64* /var/cache/apk/*  
  
VOLUME /data  
  
EXPOSE 2379 2380  
ENTRYPOINT ["/bin/etcd"]  
  
CMD ["-data-dir=/data"]  

