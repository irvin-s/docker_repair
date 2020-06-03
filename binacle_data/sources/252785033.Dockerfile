FROM alpine:2.7  
MAINTAINER Ben Merckx  
  
RUN apk add --update && apk add varnish && rm -rf /var/cache/apk/*  
  
EXPOSE 80 6082  
CMD varnishd -F -a :80 -T :6082 -f /etc/varnish/default.vcl -s malloc,2G

