FROM node:10.13-alpine

WORKDIR /app

COPY ./misc /misc
COPY server/ .
COPY docker/production/api /prod
COPY .git/ /.git
RUN sh /prod/docker-build.sh

###

FROM node:10.13-alpine

WORKDIR /app

COPY --from=0 /app /app

CMD npm start -- --config config.json
