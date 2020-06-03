FROM node:carbon-alpine

RUN npm install -g --unsafe @mdslab/wstun \
 && npm cache --force clean

ENV NODE_PATH=/usr/local/lib/node_modules

WORKDIR /usr/bin/

EXPOSE 8080

ENTRYPOINT ["wstun", "-r", "-s", "8080", "--ssl=false"]
#ENTRYPOINT ["wstun", "-r", "-s", "8080", "--ssl=true", "--key=<PRIVATE_KEY_PATH>", "--cert=<PUBLIC_KEY_PATH>"]



