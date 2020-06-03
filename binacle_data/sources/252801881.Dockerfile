FROM nginx:1.11-alpine  
COPY startup.sh /  
COPY index.html /usr/share/nginx/html  
COPY default.conf /etc/nginx/conf.d/  
RUN chmod +x startup.sh  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
ENTRYPOINT /startup.sh

