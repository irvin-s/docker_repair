FROM node:latest as build-env

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
RUN yarn

# Bundle app source
COPY . /usr/src/app

RUN yarn build

FROM nginx

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-env /usr/src/app/dist /usr/share/nginx/html
