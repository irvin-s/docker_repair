FROM nginx:1.11.10-alpine

ENV WEB_DIR=/var/web/mseva-web
RUN mkdir -p ${WEB_DIR}
COPY ./fonts ${WEB_DIR}/fonts
COPY ./images ${WEB_DIR}/images
COPY ./js ${WEB_DIR}/js
COPY ./static ${WEB_DIR}/static
COPY ./styles ${WEB_DIR}/styles
COPY ./asset-manifest.json ${WEB_DIR}/asset-manifest.json
COPY ./favicon.ico ${WEB_DIR}/favicon.ico
COPY ./favicon.png ${WEB_DIR}/favicon.png
COPY ./index.html ${WEB_DIR}/index.html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf