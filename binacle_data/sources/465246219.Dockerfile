FROM fholzer/nginx-brotli

COPY index.html /usr/share/nginx/html/index.html
COPY favicon.ico /usr/share/nginx/html/favicon.ico
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
