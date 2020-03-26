FROM node:8.7-alpine

ENV WEB_DIR=/var/web/app
RUN mkdir -p ${WEB_DIR}
COPY ./app ${WEB_DIR}/app
COPY ./templates ${WEB_DIR}/templates
COPY ./utilities ${WEB_DIR}/utilities
COPY ./index.js ${WEB_DIR}/index.js
COPY ./LICENSE ${WEB_DIR}/LICENSE
COPY ./package.json ${WEB_DIR}/package.json
COPY ./README.md ${WEB_DIR}/README.md
COPY ./server.js ${WEB_DIR}/server.js
RUN  cd ${WEB_DIR} && npm install
WORKDIR ${WEB_DIR}
CMD ["node", "server"]
