# docker build -t cgfootman/heroes:ubuntu -f ubuntu/Dockerfile .  
# docker run -d -p 80:80 --name heroesubuntu cgfootman/heroes:ubuntu  
# docker push cgfootman/heroes:ubuntu  
FROM ubuntu:16.04  
MAINTAINER Chris Gibson "cgfootman@hotmail.com"  
RUN apt-get -y -q update && apt-get -y -q install nginx  
RUN mkdir -p /var/www/html  
ADD ubuntu/nginx/global.conf /etc/nginx/conf.d/  
ADD ubuntu/nginx/nginx.conf /etc/nginx/nginx.conf  
Add Site/ /var/www/html/website  
EXPOSE 80  
# From Nginx container  
RUN ln -sf /dev/stdout /var/log/nginx/access.log  
  
RUN ln -sf /dev/stderr /var/log/nginx/error.log  
  
CMD ["nginx", "-g", "daemon off;"]  
  

