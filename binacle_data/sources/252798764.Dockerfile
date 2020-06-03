FROM nginx:1.9  
RUN mkdir -p /usr/src/app  
COPY default.conf /etc/nginx/conf.d/default.conf  

