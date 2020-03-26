FROM node:8-alpine
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /opt/app && cp -a /tmp/node_modules /opt/app/ && rm -rf /tmp/*
WORKDIR /opt/app
ADD main.js index.html /opt/app/
ENTRYPOINT ["node","main.js"]