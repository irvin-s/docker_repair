FROM nginx:latest  
MAINTAINER Dr.Doom doom@dev-ops.de  
  
COPY * /usr/share/nginx/html/  
ADD css /usr/share/nginx/html/css  
ADD img /usr/share/nginx/html/img  
ADD js /usr/share/nginx/html/js  

