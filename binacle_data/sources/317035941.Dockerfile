FROM node:10.6.0

COPY . /app/api-node

WORKDIR /app/api-node

RUN npm install

ENV NODE_ENV=PRODUCAO

ENV PORT=9000

CMD [ "npm", "start" ]

EXPOSE 9000