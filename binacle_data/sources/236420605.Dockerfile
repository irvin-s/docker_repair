FROM nginx:1.11

RUN mkdir /etc/nginx/sites-available && rm /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/

COPY scripts /root/scripts/
COPY certs/* /etc/ssl/

COPY sites /etc/nginx/templates

ARG CLIENT_PORT=3000
ARG API_PORT=8080
ARG WEB_SSL=false
ARG SELF_SIGNED=false
ARG NO_DEFAULT=false

ENV CLIENT_PORT=$CLIENT_PORT
ENV API_PORT=$API_PORT
ENV WEB_SSL=$WEB_SSL
ENV SELF_SIGNED=$SELF_SIGNED
ENV NO_DEFAULT=$NO_DEFAULT

RUN /bin/bash /root/scripts/build-nginx.sh

CMD nginx
