FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY nginx.vh.default.conf.tmpl /tmp/nginx.vh.default.conf.tmpl  
  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

