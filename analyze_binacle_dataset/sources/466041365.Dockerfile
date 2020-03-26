FROM node

WORKDIR /usr/app

COPY package.json ./

RUN npm i

COPY . .

RUN npm run build

ENV NODE_ENV=production
EXPOSE 3000
CMD [ "node", "server.js" ]
USER node