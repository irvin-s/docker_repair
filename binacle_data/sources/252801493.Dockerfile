FROM alpine:edge  
MAINTAINER EaseWay Hu <easeway@gmail.com>  
  
RUN apk add --update-cache socat curl bash openssl lighttpd && \  
rm -fr /var/cache/apk/* /tmp/*  
ADD ./server /opt/ca  
RUN chmod a+rx /opt/ca/bin/* /opt/ca/cgi/*  
  
VOLUME ["/var/lib/ca"]  
  
ENTRYPOINT ["/opt/ca/bin/start.sh"]  

