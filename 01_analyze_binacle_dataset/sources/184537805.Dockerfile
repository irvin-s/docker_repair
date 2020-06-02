FROM node:8 as node_builder
ADD . /client-src
WORKDIR /client-src
RUN npm install && npm install -g serve && npm run build

CMD [ "serve", "-s", "build", "-l", "4000" ]