FROM borrowshare/nginx-new:master  
  
RUN /bin/bash -c 'apt-get update && apt-get -y install curl && apt-get clean'  
  
COPY ssl/server.crt /etc/nginx/server.crt  
COPY ssl/server.key /etc/nginx/server.key  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
COPY . /usr/share/nginx/html  
  
RUN rm -rf /usr/share/nginx/html/ssl  
RUN rm -rf /usr/share/nginx/html/default.conf  
  
WORKDIR "/usr/share/nginx/html"  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]  

