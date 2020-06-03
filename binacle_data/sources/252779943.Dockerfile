FROM nginx:latest  
COPY default.conf /etc/nginx/conf.d/  
COPY index.html /usr/share/nginx/html/  
COPY content.json /usr/share/nginx/html/  
RUN /usr/sbin/nginx -t  
CMD nginx -g 'daemon off;'  
EXPOSE 80  

