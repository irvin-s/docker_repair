FROM alpine:latest  
  
RUN apk add \--no-cache \  
tar \  
&& addgroup -S www-data -g 82 \  
&& adduser -D -S -H -s /sbin/nologin -G www-data www-data -u 82 \  
&& mkdir -p /app \  
&& chown www-data:www-data /app \  
&& chmod 755 /app  
  
USER www-data:www-data  
  
WORKDIR /app  

