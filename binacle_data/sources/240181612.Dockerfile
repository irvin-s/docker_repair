FROM nginx:1.11.10-alpine

ENV WEB_DIR=/var/web/dashboard
RUN mkdir -p ${WEB_DIR}
ADD kibana-dashboard ${WEB_DIR}
COPY nginx.conf /etc/nginx/conf.d/default.conf
