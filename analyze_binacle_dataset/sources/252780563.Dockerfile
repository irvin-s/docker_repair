FROM gliderlabs/alpine:3.1  
# Update index of available packages, install nginx, then remove index  
RUN apk add --update nginx && rm -rf /var/cache/apk/*  
  
# Nginx needs a temporary directory  
RUN mkdir -p /tmp/nginx  
  
ONBUILD COPY . /usr/html/  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

