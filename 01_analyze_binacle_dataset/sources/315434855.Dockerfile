FROM node:8.11.1

ENV WORK_DIR="/var"

COPY / WORK_DIR

WORKDIR WORK_DIR

RUN yarn install

CMD [ "node", "src/server/index.js" ]