FROM chauffer/nginx-for-rancher  
MAINTAINER Simone Esposito <chaufnet@gmail.com>  
  
RUN echo '\  
server { \  
server_name chauf.net; \  
return 302 https://simone.sh$request_uri; \  
} \  
server { \  
server_name ~^(\w+)\.chauf\.net$; \  
return 302 https://$1.simone.sh$request_uri; \  
} \  
server { \  
listen 81; \  
location / { \  
return 200; \  
} \  
}' > /etc/nginx/conf.d/default.conf  
  
EXPOSE 80 81  
  
CMD ["nginx", "-g", "daemon off;"]  

