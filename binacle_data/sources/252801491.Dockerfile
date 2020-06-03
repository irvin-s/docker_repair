FROM alpine:edge  
MAINTAINER EaseWay Hu <easeway@gmail.com>  
  
ADD ./server /opt/openvpn  
RUN apk add --update-cache \  
bash socat curl \  
openvpn openssl \  
lighttpd && \  
rm -fr /var/cache/apk/* /tmp/* && \  
chmod a+rx /opt/openvpn/bin/* /opt/openvpn/cgi/*  
  
VOLUME ["/var/lib/openvpn"]  
  
ENTRYPOINT ["/opt/openvpn/bin/start.sh"]  

