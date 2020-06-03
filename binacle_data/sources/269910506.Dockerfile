FROM node:6.9.4-alpine
RUN mkdir /app
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./src /app/src
EXPOSE 3000 5858
CMD node --inspect=5858 src/server.js