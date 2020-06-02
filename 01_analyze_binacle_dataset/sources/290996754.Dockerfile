FROM node:9 AS base

WORKDIR /app/common
COPY common/package.json .
COPY common/yarn.lock .
RUN yarn install  --no-progress
COPY common/ .
RUN yarn run build

WORKDIR /app/api
COPY api/package.json .
COPY api/yarn.lock .
RUN yarn install --no-progress
COPY api/ .
RUN yarn run build


FROM node:9

WORKDIR /app/common
COPY common/package.json .
COPY --from=base /app/common/node_modules ./node_modules
COPY --from=base /app/common/lib ./lib

WORKDIR /app/api
COPY api/package.json .
COPY --from=base /app/api/resources ./resources
COPY --from=base /app/api/node_modules ./node_modules
COPY --from=base /app/api/build ./build

CMD yarn start
