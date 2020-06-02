FROM openresty/openresty:alpine
COPY nginx.conf usr/local/openresty/nginx/conf/
COPY html/ /usr/local/openresty/nginx/html/
EXPOSE 80
EXPOSE 443

