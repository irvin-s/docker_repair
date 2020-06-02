FROM node:9 AS base

WORKDIR /app/common
COPY common/package.json .
COPY common/yarn.lock .
RUN yarn install  --no-progress
COPY common .
RUN yarn run build

WORKDIR /app/frontend
COPY frontend/package.json .
COPY frontend/yarn.lock .
RUN yarn install  --no-progress --production false
COPY frontend .
RUN yarn run build
RUN rm -rf node_modules
RUN yarn install --no-progress --production true


FROM node:9

WORKDIR /app
COPY --from=base /app/frontend .
CMD yarn start
