FROM node

COPY . /app

WORKDIR /app

RUN npm install --production

CMD [ "node", "server.js"]
