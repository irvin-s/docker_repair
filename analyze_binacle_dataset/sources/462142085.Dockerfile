# Prepare

FROM node:10.9.0-alpine

WORKDIR /opt/app

# Install

COPY package.json yarn.lock ./

RUN yarn

# Run

COPY . /opt/app

ENV NODE_ENV development

ENTRYPOINT ["yarn"]
