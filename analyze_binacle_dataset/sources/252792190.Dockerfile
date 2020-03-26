FROM chauffer/nginx-for-rancher  
MAINTAINER Simone Esposito <chaufnet@gmail.com>  
  
RUN echo 'server { \  
listen 80; \  
return 301 https://$host$request_uri; \  
} \  
server { \  
listen 81; \  
location / { \  
return 200; \  
} \  
}' > /etc/nginx/conf.d/default.conf  
  
EXPOSE 80 81  
CMD ["nginx", "-g", "daemon off;"]  

