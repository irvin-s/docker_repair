FROM nginx:1.13.0

COPY nginx/default.conf /etc/nginx/conf.d/

EXPOSE 80
