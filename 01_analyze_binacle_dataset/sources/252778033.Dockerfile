FROM nginx  
  
MAINTAINER Andrey Portnov <aportnov@gmail.com>  
  
COPY def.conf /etc/nginx/conf.d/  
  
CMD ["nginx", "-g", "daemon off;"]  

