FROM nginx
COPY contiv-nginx.conf /etc/nginx/conf.d/default.conf
COPY app /usr/share/nginx/html
