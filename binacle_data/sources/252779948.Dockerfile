FROM nginx:latest  
MAINTAINER axel.pavageau@gmail.com  
COPY files/nginx.conf /etc/nginx/nginx.conf  
RUN nginx -t  
CMD nginx -g 'daemon off;'  
EXPOSE 80 443 8080  

