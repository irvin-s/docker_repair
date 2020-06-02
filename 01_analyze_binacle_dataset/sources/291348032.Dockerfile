FROM node:latest

EXPOSE 3001

ADD package.json package.json

RUN npm install

ADD . .

CMD ["node","app.js"]