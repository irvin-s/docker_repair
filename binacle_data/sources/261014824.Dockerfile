FROM node:8

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN npm install
RUN npm install forever -g

EXPOSE 3100

CMD [ "forever", "app.js" ]
