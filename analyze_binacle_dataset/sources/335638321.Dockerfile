# this Dockerfile expects the root of the project to be its context, e.g.:
# docker build -f expander/nodejs/Dockerfile .
FROM node:8-alpine

RUN mkdir -p /app/expander/nodejs
WORKDIR /app/expander/nodejs
ADD ./expander/nodejs/package.json ./package.json
ADD ./expander/nodejs/package-lock.json ./package-lock.json
RUN npm install

WORKDIR /app
ADD ./expander/nodejs ./expander/nodejs
ADD ./lib ./lib
WORKDIR /app/expander/nodejs

CMD [ "npm", "start" ]

EXPOSE 10000

