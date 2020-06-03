FROM nginx:mainline-alpine

COPY *.conf /etc/nginx/conf.d/

EXPOSE 80
