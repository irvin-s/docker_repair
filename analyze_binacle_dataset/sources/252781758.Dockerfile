FROM alpine:3.2  
MAINTAINER Chris George "chris.a.george@gmail.com"  
# install common packages  
RUN apk add --update-cache \  
bash \  
curl \  
geoip \  
libssl1.0 \  
openssl \  
pcre \  
sudo \  
&& rm -rf /var/cache/apk/*  
  
# add nginx user  
RUN addgroup -S nginx && \  
adduser -S -G nginx -H -h /opt/nginx -s /sbin/nologin -D nginx  
  
COPY rootfs /  
RUN build  
COPY conf /opt/nginx/conf/  
  
EXPOSE 80 443  
CMD ["/opt/nginx/sbin/nginx", "-c", "/opt/nginx/conf/nginx.conf"]  

