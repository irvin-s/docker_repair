FROM node:carbon-alpine

ENV NODE_ENV production
ENV PORT 3000

RUN mkdir -p /usr/src/app
COPY . /usr/src/app

WORKDIR /usr/src/app

RUN npm install
RUN npm run build

ENTRYPOINT ["node", "server.js"]
CMD ["node", "server.js"]
