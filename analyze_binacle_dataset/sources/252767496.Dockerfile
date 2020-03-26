FROM nginx:alpine  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf  
  
EXPOSE 80  
STOPSIGNAL SIGTERM  
CMD ["nginx", "-g", "daemon off;"]  

