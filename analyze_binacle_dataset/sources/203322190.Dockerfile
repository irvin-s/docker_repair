FROM node:6.4

ENV NPM_CONFIG_LOGLEVEL warn

WORKDIR /code/

COPY npm-shrinkwrap.json .

RUN npm install

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
