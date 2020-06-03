FROM node:10.12-alpine AS node

#RUN apk update && apk add libpng-dev
RUN apk update && apk add --no-cache --update make gcc g++ libc-dev libpng-dev automake autoconf libtool

RUN npm install gulp -g

WORKDIR /app

COPY .eslintrc.js aliases.config.js gulpfile.js package.json vue.config.js webpack.mix.js yarn.lock /app/
# RUN npm install && npm prune --production
RUN yarn install
COPY . /app/
RUN yarn cjs && gulp locale_sync && gulp public-image && yarn build

FROM nginx:1.15.4

WORKDIR /usr/share/nginx/html
COPY --from=node /app/dist /usr/share/nginx/html
