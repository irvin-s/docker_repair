FROM node:alpine
RUN apk add --no-cache make gcc g++ python
RUN rm -rf /usr/src/pixi/web/uploads
RUN mkdir -p /usr/src/pixi/web
WORKDIR /usr/src/pixi/web
COPY package.json /usr/src/pixi/web

RUN npm install --save
RUN npm install --save express 

COPY . /usr/src/pixi/web
COPY uploads/ /usr/src/pixi/web/uploads/

RUN npm install -g nodemon

EXPOSE 8000
CMD ["nodemon", "/usr/src/pixi/web/server.js"]