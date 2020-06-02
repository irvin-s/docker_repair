FROM nginx:1.11.5-alpine

COPY ./files/nginx.conf /etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
