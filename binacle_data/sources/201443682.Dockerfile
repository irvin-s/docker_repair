FROM nginx:alpine
COPY . /usr/share/nginx/html/
CMD envsubst < /usr/share/nginx/html/docker/nginx.conf > /etc/nginx/conf.d/default.conf; exec nginx -g 'daemon off;'
