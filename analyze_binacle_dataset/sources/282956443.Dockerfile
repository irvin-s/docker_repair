FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY static /static