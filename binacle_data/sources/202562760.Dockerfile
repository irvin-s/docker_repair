FROM nginx:1.9

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY html /usr/share/nginx/html