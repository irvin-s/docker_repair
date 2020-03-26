FROM jamespan/alpine-nginx:latest

MAINTAINER Pan Jiabang <panjiabang@gmail.com>

# Copy blog content

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
