FROM nginx:stable

RUN apt-get update -qq && apt-get install -y netcat

COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY start /docker/
