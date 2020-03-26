FROM nginx:latest

RUN apt-get update; apt-get install -y links iputils-ping vim
COPY compose/production/nginx/nginx.conf  /etc/nginx/nginx.conf
