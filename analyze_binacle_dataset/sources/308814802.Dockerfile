FROM node:latest

WORKDIR /var/lib/lxdhub

RUN npm i -g yarn@1.7.0
COPY package.json yarn.lock lerna.json ./
RUN yarn --pure-lockfile
COPY . .
RUN yarn bootstrap

ENTRYPOINT [ "yarn", "run" ]
CMD [ "start" ]
