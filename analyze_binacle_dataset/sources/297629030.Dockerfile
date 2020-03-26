FROM node:7.7.2

ENV PORT 8080
ENV HOST 0.0.0.0

ADD "." "/home/node/zenhub-pipe"

WORKDIR /home/node/zenhub-pipe
RUN chown -R node. /home/node/*

USER node

RUN npm i

EXPOSE $PORT
CMD [ "node", "./src/server.js" ]