FROM node:8.7-alpine

ENV WEB_DIR=/var/web/app
RUN mkdir -p ${WEB_DIR}
COPY ./config.js ${WEB_DIR}/config.js
COPY ./index.html ${WEB_DIR}/index.html
COPY ./server.js ${WEB_DIR}/server.js
COPY ./package.json ${WEB_DIR}/package.json
COPY ./package-lock.json ${WEB_DIR}/package-lock.json
RUN  cd ${WEB_DIR} && npm install
WORKDIR ${WEB_DIR}
CMD ["node", "server"]
