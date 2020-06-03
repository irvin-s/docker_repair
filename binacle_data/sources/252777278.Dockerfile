FROM nginx:1.13  
ADD ./nginx.conf /etc/nginx/nginx.conf.tpl  
ADD ./my_nginx /usr/local/bin/my_nginx  
CMD ["my_nginx", "-g", "daemon off;"]  

