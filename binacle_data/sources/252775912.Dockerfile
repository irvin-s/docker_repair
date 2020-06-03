FROM alpine:latest  
RUN apk update && apk add collectd  
COPY collectd.conf /etc/collectd/collectd.conf  
VOLUME /var/lib/collectd  
CMD collectd -f  

