FROM nginx:1.13.11  
COPY . /etc/nginx/conf.d  
  
CMD ["nginx", "-g", "daemon off;"]  

