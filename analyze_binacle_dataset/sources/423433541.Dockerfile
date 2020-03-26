FROM node:lts-alpine
LABEL maintainer="leon.machens@gmail.com"

EXPOSE 3000

RUN npm install -g yarn
COPY next.config.js next.config.js
COPY package.json package.json
RUN yarn install

COPY dist dist
COPY static static

CMD ["yarn", "start"]