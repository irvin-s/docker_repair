FROM nginx
COPY dist /usr/share/nginx/html
COPY server.conf /etc/nginx/conf.d/default.conf
COPY ssl.crt /etc/nginx/ssl.crt
COPY ssl.key /etc/nginx/ssl.key