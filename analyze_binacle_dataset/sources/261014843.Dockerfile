FROM nginx

RUN apt-get update
RUN apt-get install -y wget

COPY ./static /usr/share/nginx/html
COPY ./dc.conf /etc/nginx/conf.d/default.conf
