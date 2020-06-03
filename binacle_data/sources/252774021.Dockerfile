FROM nginx:1.11  
  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD server_locations.conf /etc/nginx/conf.d/server_locations.conf  
ADD server_upstreams.conf /etc/nginx/conf.d/server_upstreams.conf

