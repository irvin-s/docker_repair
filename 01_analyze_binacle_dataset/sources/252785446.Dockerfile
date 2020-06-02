FROM colstrom/alpine  
  
RUN apk-install nginx-naxsi@testing \  
&& mkdir -p /tmp/nginx  
  
EXPOSE 80 443  
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]  

