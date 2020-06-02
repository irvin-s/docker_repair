FROM nginx:1.11.10-alpine

ENV WEB_DIR=/var/web/app
RUN mkdir -p ${WEB_DIR}/v2
COPY ./build ${WEB_DIR}/v2
