# Multi-stage dockerfile where the 1st stage builds the app on a specific version of node,
# and the 2nd stage sets up the latest nginx:alpine.

# ============================== node/build section =====================================================
FROM node:8.15-alpine as build_section

# build dependencies:
RUN apk update
RUN apk add --update make
RUN apk add --update g++
RUN apk add --update python2
RUN apk add --update git

# copy build config:
COPY ./*.* /var/www/
COPY ./LICENSE /var/www/
WORKDIR /var/www
# install project dependencies via yarn:
RUN yarn install
# copy rest of code (we do this only here to avoid "install dependencies" step above each time *only* the code changes):
COPY . /var/www/
# build code:
RUN yarn run full-install

# ============================== nginx section =====================================================
FROM nginx:alpine

# use jq to update custom.json at runtime
RUN apk update && apk add jq

# copy build result from 1st stage
COPY --from=build_section /var/www/app/ /var/www/app/

# append custom CSS to the end of main .css file:
RUN ( ls /var/www/app/config/custom_style.css && cat /var/www/app/config/custom_style.css >> /var/www/app/build/OpenTargetsWebapp.min.css) || echo 'No custom .css'

#move self-signed certificates in the right place
COPY ./nginx_conf/server.crt /usr/share/nginx/
COPY ./nginx_conf/server.key /usr/share/nginx/

#move nginx.template in the right place
COPY ./nginx_conf/nginx.template /etc/nginx/nginx.template

VOLUME /var/cache/nginx

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443
WORKDIR /var/www/app
CMD ["nginx", "-g", "daemon off;"]
