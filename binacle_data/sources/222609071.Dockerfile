## Build
FROM node:8.6.0-alpine
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

COPY package.json /usr/src/app/
RUN npm install

COPY . /usr/src/app/
RUN npm run build && npm cache clean --force

## Server
FROM nginx:1.13.5-alpine
COPY --from=0 /usr/src/app/public /usr/share/nginx/html/public/
COPY --from=0 /usr/src/app/samling.html /usr/share/nginx/html/index.html
