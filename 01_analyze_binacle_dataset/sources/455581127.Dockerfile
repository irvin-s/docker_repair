FROM node:6.1

WORKDIR /packages
ADD package.json /packages/package.json
RUN npm install

WORKDIR /app
ADD . /app
RUN rm -rf /app/node_modules && mv /packages/node_modules /app/node_modules

CMD npm start
