FROM node:10

COPY . /app

WORKDIR /app

ENV NODE_ENV=production

RUN yarn install

EXPOSE 3000

CMD ["npm", "run", "start"]
