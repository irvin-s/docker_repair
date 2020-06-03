# this Dockerfile expects the root of the project to be its context, e.g.:
# docker build -f shortener/Dockerfile .
FROM node:8-alpine

RUN npm install -g poi@9.6.8

RUN mkdir -p /app/shortener/server /app/shortener/client
ADD ./lib /app/lib

WORKDIR /app/shortener/client
ADD ./shortener/client .
RUN npm install && npm run build && rm -rf ./node_modules

WORKDIR /app/shortener/server
ADD ./shortener/server .
RUN npm install

CMD [ "npm", "start" ]

EXPOSE 20000

