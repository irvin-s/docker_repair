FROM jwilder/nginx-proxy:latest  
RUN sed -i 's/^http {/&\n client_max_body_size 100M;/g' /etc/nginx/nginx.conf  
COPY app/* /app/  

