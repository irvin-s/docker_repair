# Dockerfile
FROM node:9.6.1

RUN mkdir /app
WORKDIR /app
COPY package.json /app/package.json

ENV PATH /app/node_modules/.bin:$PATH

RUN npm install --silent
RUN npm install react-scripts -g --silent

COPY . /app

CMD ["npm", "start"]

EXPOSE 3000
