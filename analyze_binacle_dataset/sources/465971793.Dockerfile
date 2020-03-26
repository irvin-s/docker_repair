FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html
COPY site .

CMD nginx -g 'daemon off;'
