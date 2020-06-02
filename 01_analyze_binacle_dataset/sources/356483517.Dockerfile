FROM nginx:1.7

COPY ./etc/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/sites-enabled /etc/nginx/sites-enabled
