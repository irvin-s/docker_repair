FROM node

MAINTAINER Christian Schuller <cschuller@servusalps.com>

ENV YAKJS_VERSION=3.4.2

RUN npm install -g yakjs@${YAKJS_VERSION}

CMD [ "node", "/usr/local/lib/node_modules/yakjs/bin/yakjs-cli.js"]

EXPOSE 8790
