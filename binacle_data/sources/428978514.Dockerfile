FROM node:8

WORKDIR /usr/src/app

COPY ./package.json ./

RUN npm install

COPY ./easy.js .

COPY ./index.html .

EXPOSE 4000

CMD [ "node", "easy.js" ]
