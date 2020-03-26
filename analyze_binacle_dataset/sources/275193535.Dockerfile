FROM node:alpine

RUN mkdir /app

WORKDIR /app

CMD ["npm", "run", "dev"]