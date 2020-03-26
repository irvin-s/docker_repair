FROM node:12.0.0

WORKDIR /usr/src/app

EXPOSE 8080

COPY package.json /usr/src/app/

RUN npm install

COPY index.js /usr/src/app/

CMD node index.js
