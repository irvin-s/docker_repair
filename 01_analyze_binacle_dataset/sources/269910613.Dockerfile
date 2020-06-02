FROM node:8-alpine
RUN npm install nodemon -g
RUN mkdir /app
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./src /app/src
EXPOSE 3000
CMD nodemon src/server.js 0.0.0.0:3000