# Stage 0, "build-stage", based on Node.js, to build the front app
FROM node:alpine as build-stage
MAINTAINER Louis TREZZINI <louis.trezzini@ponts.org>

WORKDIR /app

RUN apk --no-cache add git
RUN npm install -g -s --no-progress yarn

COPY package.json yarn.lock /app/
RUN yarn --frozen-lockfile

COPY . /app/
RUN yarn build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:alpine
COPY --from=build-stage /app/dist/ /app/front/
COPY default.conf /etc/nginx/conf.d/
