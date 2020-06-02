FROM nginx:latest  
MAINTAINER Dr.Doom doom@dev-ops.de  
  
COPY * /usr/share/nginx/html/  
ADD deps /usr/share/nginx/html/deps  
VOLUME ["/usr/share/nginx/html/"]  

