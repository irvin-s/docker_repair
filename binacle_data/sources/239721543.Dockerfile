FROM nginx:1.11.10-alpine

ENV WEB_DIR=/var/web/pgr-web
RUN mkdir -p ${WEB_DIR}
COPY ./resources ${WEB_DIR}/resources
COPY ./templates ${WEB_DIR}/templates
COPY ./index.html ${WEB_DIR}/index.html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
