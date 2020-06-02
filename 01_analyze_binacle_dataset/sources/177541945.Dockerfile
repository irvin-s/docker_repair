from nginx

COPY sites/worldping.conf /etc/nginx/conf.d/
COPY sites/crt.pem /etc/ssl/private/
COPY sites/key.pem /etc/ssl/private/
