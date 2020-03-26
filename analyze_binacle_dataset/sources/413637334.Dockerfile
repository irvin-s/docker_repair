FROM nginx:latest

COPY site.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
