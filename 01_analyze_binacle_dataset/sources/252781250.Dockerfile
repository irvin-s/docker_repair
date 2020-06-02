from nginx:alpine  
MAINTAINER cowpannda<ynw506@gmail.com>  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
CMD ["nginx", "-g", "daemon off;"]  

