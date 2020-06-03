FROM node:alpine

WORKDIR /app
COPY . /app

ENV PORT 8000
EXPOSE 8000

RUN npm install

CMD ["npm","run","start"]

