FROM node:10-alpine
LABEL maintainer="docker@lagden.in"

RUN apk --update add --no-cache acl

ARG NODE_ENV=production
ARG PORT=3000
ARG BASE=/home/node

ENV NODE_ENV=$NODE_ENV
ENV PORT=$PORT
ENV BASE=$BASE
ENV APP=$BASE/app
ENV NPM_CMD="npm i --progress=false --quiet"

EXPOSE $PORT

# Para fazer debug do Node.js
# EXPOSE 9229

RUN npm i -g npm
RUN mkdir -p $APP
COPY . $APP

WORKDIR $APP

RUN setfacl -R -m d:u:node:rwx,u:node:rwX $BASE

USER node
RUN $NPM_CMD
