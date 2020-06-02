FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
# error pages  
COPY maintenance.html /locust/www/fallback/htdocs/maintenance.html  

