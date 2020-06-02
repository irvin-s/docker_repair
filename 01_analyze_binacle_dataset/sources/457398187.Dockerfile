FROM node:latest

ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /app && cp -a /tmp/node_modules /app/

COPY package.json internal.cert internal.key index.js /app/
COPY lib/ /app/lib/
WORKDIR /app
CMD ["node", "/app/index.js"]