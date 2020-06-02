FROM node:8-alpine
RUN npm install -g jasmine-node
RUN mkdir /app
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./src /app/src
COPY ./specs /app/specs
EXPOSE 3000
CMD node src/server.js