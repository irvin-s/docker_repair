# Version: 0.0.1  
FROM ubuntu  
LABEL maintainer="dmitry@biletskyy.com"  
RUN apt-get update; apt-get install -y nginx  
RUN echo 'Hi, I am in your container, updated' \  
>/var/www/html/index.html  
EXPOSE 80  
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]  

