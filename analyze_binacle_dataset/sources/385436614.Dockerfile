FROM nginx
COPY html /webmap
COPY nginx.conf /etc/nginx/nginx.conf
VOLUME ["/webmap"]


