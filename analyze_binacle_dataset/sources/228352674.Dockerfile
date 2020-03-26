FROM node:10

WORKDIR /rest-on-couch-source
COPY ./  ./
RUN npm ci && npm run build && rm -rf node_modules

ENV NODE_ENV production
ENV REST_ON_COUCH_HOME_DIR /rest-on-couch
RUN npm install -g pm2 && npm ci && rm -rf /root/.npm

CMD ["node", "bin/rest-on-couch-server.js"]
