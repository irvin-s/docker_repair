FROM node:10-alpine

WORKDIR /usr/src/app
COPY . .
RUN npm install && npm run build

EXPOSE 3100

CMD npm start
