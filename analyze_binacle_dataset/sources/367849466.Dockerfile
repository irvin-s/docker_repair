FROM nginx

ADD nginx.conf /etc/nginx/nginx.conf
ADD cors.conf /etc/nginx/cors.conf
ADD *.pem /etc/ssl/
