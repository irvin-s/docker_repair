FROM node:4.4.0

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

RUN npm install -g elm
COPY . /usr/src/app


ENV NPM_CONFIG_LOGLEVEL error


RUN npm install

RUN npm run installextra


EXPOSE 8080

ENV LC_ALL C.UTF-8

CMD ["npm", "start"]
