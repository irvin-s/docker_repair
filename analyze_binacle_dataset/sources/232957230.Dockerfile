FROM node:7

WORKDIR /usr/src/app
COPY package.json app.js LICENSE /usr/src/app/
COPY lib /usr/src/app/lib/

LABEL license MIT
ENV NODE_ENV production

RUN npm update

CMD ["node", "app.js"]
