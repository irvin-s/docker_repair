FROM node:8.6-alpine

RUN apk add --update-cache build-base python git

WORKDIR /app

ENV NODE_ENV development

COPY ./package.json /app/package.json
RUN npm install nodemon -g
RUN npm install --quiet

COPY . /app

EXPOSE 3332

ENV NODE_ENV production

CMD ["npm", "run", "start:prod"]