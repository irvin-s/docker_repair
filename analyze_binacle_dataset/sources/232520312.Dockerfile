FROM node:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json package.json
RUN npm install

COPY . .

CMD [ "npm", "run", "start:prod" ]
