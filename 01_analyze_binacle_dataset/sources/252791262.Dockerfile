FROM nginx:alpine  
  
ADD ["./nginx.conf", "/etc/nginx/nginx.conf"]  
ADD ["./custom_errors.conf", "/etc/nginx/custom_errors.conf"]  
  
ADD ["./conf.d/caching-proxies.conf", "/etc/nginx/conf.d/default.conf"]  
  
ADD ["./html", "/var/www/html"]  
  

