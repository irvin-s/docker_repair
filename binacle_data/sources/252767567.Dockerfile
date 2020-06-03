FROM nginx:1.11.6-alpine  
COPY nginx.conf /etc/nginx/nginx.conf  
RUN echo "This image was created: $(date)" > /usr/share/nginx/html/index.html

