FROM node:0.10

RUN mkdir -p /app
WORKDIR /app
COPY package.json /app/
RUN npm install

EXPOSE 3000
