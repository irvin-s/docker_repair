FROM alpine:latest  
  
RUN apk add --no-cache nginx  
RUN mkdir -p /run/nginx  
  
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]  
  
EXPOSE 80 443  
VOLUME ["/etc/nginx"]  

