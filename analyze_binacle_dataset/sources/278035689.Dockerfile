FROM node:9.2.0-alpine

ARG NODE_ENV=test
ARG DEBUG=Rollbar:*
ARG DB_PASS
ARG COMMIT_HASH
ARG JWT_SIGNING_KEY
ARG SENDGRID_API_KEY
ARG ROLLBAR_API_KEY
ARG HOST_DOMAIN
ARG DB_HOST
ARG DB_REPLICA_SET

ENV NODE_ENV=$NODE_ENV
ENV DEBUG=$DEBUG
ENV DB_PASS=$DB_PASS
ENV COMMIT_HASH=$COMMIT_HASH
ENV JWT_SIGNING_KEY=$JWT_SIGNING_KEY
ENV SENDGRID_API_KEY=$SENDGRID_API_KEY
ENV ROLLBAR_API_KEY=$ROLLBAR_API_KEY
ENV HOST_DOMAIN=$HOST_DOMAIN
ENV DB_HOST=$DB_HOST
ENV DB_REPLICA_SET=$DB_REPLICA_SET

ENV WORKDIR=/home

RUN apk update && \
    apk add yarn bash && \
    apk --no-cache add --virtual builds-deps build-base python
RUN rm -rf /var/cache/apk/*

COPY package.json yarn.lock $WORKDIR/
RUN cd $WORKDIR && \
    yarn --production

COPY .babelrc webpack.config.js $WORKDIR/
COPY client $WORKDIR/client
COPY server $WORKDIR/server
COPY .setup $WORKDIR/.setup
RUN cd $WORKDIR && \
    yarn build

WORKDIR $WORKDIR
EXPOSE 3000
CMD npm rebuild bcrypt --build-from-source && node server/
