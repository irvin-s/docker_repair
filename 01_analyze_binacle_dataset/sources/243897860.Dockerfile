FROM node:6-alpine

ADD asc.tar.gz /asc

WORKDIR /asc

RUN npm install --production

ENV NODE_ENV="production" MONGODB_HOST="mongodb" MONGODB_NAME="ASC"

EXPOSE 3000

ENTRYPOINT ["node"]
CMD ["server/index.js"]
