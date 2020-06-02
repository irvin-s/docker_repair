FROM node:10-alpine

WORKDIR /app

COPY package*.json ./

RUN apk add --no-cache --virtual build-pack git \
    && npm install \
    && apk del build-pack \
    && apk add --no-cache dumb-init

COPY . .

EXPOSE 3000

ENTRYPOINT ["dumb-init", "--"]

CMD ["npm", "run", "start"]
