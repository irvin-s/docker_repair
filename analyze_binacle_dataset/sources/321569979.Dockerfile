FROM node:8-slim

WORKDIR /abba
ENV NODE_ENV development

COPY package.json /abba/package.json

RUN npm install --production

COPY .env.example /abba/.env.example
COPY . /abba

CMD ["npm", "start"]

EXPOSE 8080
