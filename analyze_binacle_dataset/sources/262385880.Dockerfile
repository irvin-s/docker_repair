FROM nginx:latest

RUN rm /etc/nginx/nginx.conf

ADD ./nginx.conf /etc/nginx/nginx.conf

