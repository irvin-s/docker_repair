FROM nginx:stable-alpine  
RUN rm /usr/share/nginx/html/*  
COPY nginx.vh.default.conf /etc/nginx/conf.d/default.conf  
COPY sureroute.html /usr/share/nginx/html/.well-known/akamai/sureroute.html  

