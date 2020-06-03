FROM node:8-slim

COPY . /jsernews
COPY package.json /jsernews/package.json

WORKDIR /jsernews

ENV NODE_ENV production
RUN npm install --production

CMD ["npm", "start"]

EXPOSE 8888
