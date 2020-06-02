FROM nginx
COPY dst/ /usr/share/nginx/html/
EXPOSE 80
