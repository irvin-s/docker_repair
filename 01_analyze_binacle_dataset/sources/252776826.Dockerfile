FROM nginx:1.9  
COPY ./build/ /usr/share/nginx/html/  
  
CMD ["nginx", "-g", "daemon off;"]  

