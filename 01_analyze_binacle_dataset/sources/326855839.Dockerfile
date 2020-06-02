FROM node:8

WORKDIR /usr/src/app

COPY package.json .

RUN npm install

COPY keycloak.json .
COPY app.js .

EXPOSE 8080
CMD [ "npm", "start" ]
