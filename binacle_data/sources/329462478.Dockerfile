FROM node:dubnium-alpine

RUN apk add tini --no-cache
ENTRYPOINT ["/sbin/tini", "--"]

EXPOSE 80
EXPOSE 443

WORKDIR /usr/src/server

COPY package*.json ./
COPY public ./public

#install node_modules based on package.json
RUN npm i

#copy src dir from project to image
COPY src ./src

#run npm script to create a build directory in this docker image
RUN npm run build

#delete everything except the previously created build directory from this directory
RUN rm -r ./src
RUN rm -r ./public
RUN rm -r ./node_modules
RUN rm  ./package.json

#copy server/package.json and paste it as package.json alongside the build folder
COPY server/package.json ./package.json

#install node_modules based on server/package.json
#this json config contains only the minimum dependencies to support npm serve
RUN npm i --only=prod

#copy the express server.js file alongside the build folder
COPY server/server.js ./server.js
COPY server/irceline.js ./irceline.js
COPY server/luftdaten.js ./luftdaten.js

CMD [ "node", "server.js" ]