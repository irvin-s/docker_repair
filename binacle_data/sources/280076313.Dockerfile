FROM node:8.6-alpine

RUN apk add --update-cache build-base python git

WORKDIR /app

COPY ./package.json /app/package.json
RUN npm install --quiet

COPY . /app

EXPOSE 3000

CMD ["npm", "run", "start"]