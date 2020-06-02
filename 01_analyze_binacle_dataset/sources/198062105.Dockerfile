FROM nginx:1.13.8-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

