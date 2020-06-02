FROM node:10.15.1-alpine

RUN mkdir -p /opt/app
WORKDIR /opt/app

# Install / Build
COPY package.json .
COPY package-lock.json .
COPY yarn.lock .

RUN yarn --production --ignore-scripts
RUN yarn

ENV CI true

COPY .graphqlconfig .
COPY app.ts .
COPY tsconfig.json .
COPY tslint.json .
COPY config/ ./config/
COPY graphql/ ./graphql/
COPY bin/ ./bin/
COPY server/ ./server/

ENV PORT 3000
ENV ADDR 0.0.0.0
EXPOSE $PORT
